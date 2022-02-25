//
//  ViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import UIKit

class ViewController: UIViewController {

    var URLarray = [String]()
    
    var PokemonArray = [pokemon]()
    
    var colorPicker = TypeColorManager()
    var searchForPokemonUrls = PokeRequest()
    var searchForPokemonStats = PokemonStats()
    
    // Button Outlets
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var prevPageButton: UIButton!
    
    // Text Label Outlets
    @IBOutlet weak var pageLabel: UILabel!
    
    // Table View Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // Navigation Button OnClickActions
    @IBAction func prevPageClicked(_ sender: UIButton) {
        if let prev = searchForPokemonUrls.previousURL{
            searchForPokemonUrls.requestURL = prev
            searchForPokemonUrls.fetchData()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func nextPageClicked(_ sender: UIButton) {
        searchForPokemonUrls.fetchData()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchForPokemonUrls.delegate = self
        searchForPokemonStats.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        checkButton()
        
        searchForPokemonUrls.fetchData()
        
        }

}

// MARK - Pagination

extension ViewController{
    
    func checkButton(){
        if searchForPokemonUrls.previousURL == nil {
            prevPageButton.isHidden = true
        } else if searchForPokemonUrls.requestURL == nil {
            nextPageButton.isHidden = true
        } else {
            prevPageButton.isHidden = false
            nextPageButton.isHidden = false
        }
    }
    
    @IBAction func pageButtonPressed(_ sender: UIButton) {
        if sender == prevPageButton{
            pageLabel.text = String(Int(pageLabel.text!)! - 1)
            checkButton()
        } else if sender == nextPageButton {
            pageLabel.text = String(Int(pageLabel.text!)! + 1)
            checkButton()
        }
    }
}

// MARK - PokeRequestDelegate

extension ViewController: PokeRequestDelegate{
    func recievedPokeList(data: pokeData) {
        PokemonArray.removeAll()
        
        searchForPokemonUrls.requestURL = data.next

        searchForPokemonUrls.previousURL = data.previous
        
        for res in data.results{
            URLarray.append(res.url)
        }
        
        for urlStr in self.URLarray{
            self.searchForPokemonStats.requestURL = urlStr
            self.searchForPokemonStats.fetchData()
        }

        URLarray.removeAll()
        
        DispatchQueue.main.async {
            self.checkButton()
        }
        
    }
}

// MARK - PokemonStatsDelegate

extension ViewController: PokemonStatsDelegate{
    func recievedPokeInfo(data: pokemon) {
        PokemonArray.append(data)
    }
}

// MARK - TableViewDataSource

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! PokemonCell

        cell.pokemonNumber.text = String(PokemonArray[indexPath.row].id)
        cell.pokemonName.text = PokemonArray[indexPath.row].name
        cell.pokemonSprite.load(url: URL(string: PokemonArray[indexPath.row].sprites.front_default)!)
        
        if PokemonArray[indexPath.row].types.count == 2 {
            cell.type2Label.text = PokemonArray[indexPath.row].types.last?.type.name
            
            colorPicker.type = PokemonArray[indexPath.row].types.last?.type.name
            cell.type2Label.backgroundColor = colorPicker.getColorForType()
            
            cell.type2Label.isHidden = false
        } else {
            cell.type2Label.isHidden = true
        }
        cell.type1Label.text = PokemonArray[indexPath.row].types.first?.type.name
        
        colorPicker.type = PokemonArray[indexPath.row].types.first?.type.name
        cell.type1Label.backgroundColor = colorPicker.getColorForType()
            return cell
    }
}

// MARK - TableViewDelegate

extension ViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK - Load Image From URL

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
