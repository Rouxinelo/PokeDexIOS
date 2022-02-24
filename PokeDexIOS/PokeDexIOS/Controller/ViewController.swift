//
//  ViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import UIKit

class ViewController: UIViewController {

    // Button Outlets
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var prevPageButton: UIButton!
    
    // Text Label Outlets
    @IBOutlet weak var pageLabel: UILabel!
    
    // Table View Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Image View Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    
    var URLarray = [String]()
    
    var PokemonArray = [pokemon]()
    
    var searchForPokemonUrls = PokeRequest()
    var searchForPokemonStats = PokemonStats()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchForPokemonUrls.delegate = self
        searchForPokemonStats.delegate = self
        tableView.dataSource = self
        
        checkButton()
    }

}

// MARK - Pagination

extension ViewController{
    
    func checkButton(){
        if pageLabel.text == "1" {
            prevPageButton.isHidden = true
        } else if pageLabel.text == "10"{
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
        print(data.count)
        
        searchForPokemonUrls.requestURL = data.next
        if let prev = data.previous{
            searchForPokemonUrls.previousURL = prev
        }
        
        for res in data.results{
            URLarray.append(res.url)
        }
        
        for urlStr in self.URLarray{
            self.searchForPokemonStats.requestURL = urlStr
            self.searchForPokemonStats.fecthData()
        }
        
        print(PokemonArray.count)
        for poke in PokemonArray{
            print(poke.name)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        URLarray.removeAll()
    }
}

// MARK - PokemonStatsDelegate

extension ViewController: PokemonStatsDelegate{
    func recievedPokeInfo(data: pokemon) {
        if PokemonArray.firstIndex(of: data) != nil{
            return
        }
        PokemonArray.append(data)
    }
}

// MARK - TableViewDataSource

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = "\(PokemonArray[indexPath.row].id) - \(PokemonArray[indexPath.row].name)"
        return cell
    }
}
