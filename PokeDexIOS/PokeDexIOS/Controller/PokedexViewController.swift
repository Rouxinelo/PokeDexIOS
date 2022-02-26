//
//  ViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import UIKit

class PokedexViewController: UIViewController {
    
    let pokemonPerPage = 7
    var maxPages: Int? = 0
    
    var URLarray = [String]()
    
    var PokemonArray = [pokemon]()
    
    var colorPicker = TypeColorManager()
    
    var searchForPokemonUrls = PokeRequest()
    var searchForPokemonStats = PokemonStats()
    
    // Button Outlets
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var prevPageButton: UIButton!
    @IBOutlet weak var firstPageButton: UIButton!
    @IBOutlet weak var lastPageButton: UIButton!
    
    // Text Label Outlets
    @IBOutlet weak var pageLabel: UILabel!
    
    // Table View Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Search Bar Outlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    // Bar Button OnClickAction
    @IBAction func InformationClicked(_ sender: Any) {
        performSegue(withIdentifier: K.Segues.pokeDexToAboutMe, sender: sender)
    }
    
    // Navigation Button OnClickActions
    @IBAction func prevPageClicked(_ sender: UIButton) {
        if sender == prevPageButton{
            if let prev = searchForPokemonUrls.previousURL{
                searchForPokemonUrls.requestURL = prev
            }
        } else if sender == firstPageButton{
            searchForPokemonUrls.requestURL = searchForPokemonUrls.firstPageURL
        }
        searchForPokemonUrls.fetchData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func nextPageClicked(_ sender: UIButton) {
        if(sender == lastPageButton){
            searchForPokemonUrls.requestURL = searchForPokemonUrls.lastPageURL
            searchForPokemonUrls.fetchData()
        } else if sender == nextPageButton {
            searchForPokemonUrls.fetchData()
        }
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
        pokemonSearchBar.delegate = self
        
        tableView.register(UINib(nibName: K.TableCells.pokeDexCellNibName, bundle: nil), forCellReuseIdentifier: K.TableCells.pokeDexCellIdentifier)
        
        searchForPokemonUrls.fetchPokeNumber()
                
        checkButton()
        
        searchForPokemonUrls.fetchData()

    }
}

// MARK - Pagination

extension PokedexViewController{
    
    func checkButton(){
        if pageLabel.text == "1" {
            nextPageButton.isHidden = false
            lastPageButton.isHidden = false
            prevPageButton.isHidden = true
            firstPageButton.isHidden = true
        } else if pageLabel.text == String(maxPages!) {
            nextPageButton.isHidden = true
            lastPageButton.isHidden = true
            firstPageButton.isHidden = false
            prevPageButton.isHidden = false
        } else {
            prevPageButton.isHidden = false
            nextPageButton.isHidden = false
            firstPageButton.isHidden = false
            lastPageButton.isHidden = false
        }
    }
    
    @IBAction func pageButtonPressed(_ sender: UIButton) {
        if sender == prevPageButton{
            pageLabel.text = String(Int(pageLabel.text!)! - 1)
            checkButton()
        } else if sender == nextPageButton {
            pageLabel.text = String(Int(pageLabel.text!)! + 1)
            checkButton()
        } else if sender == firstPageButton{
            pageLabel.text = "1"
            checkButton()
        } else if sender == lastPageButton{
            pageLabel.text = String(maxPages!)
            checkButton()
        }
    }
}

// MARK - PokeRequestDelegate

extension PokedexViewController: PokeRequestDelegate{
    
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
    
    func recievedPokeCount(count: Int) {
        print(count % self.pokemonPerPage)
        print(count/self.pokemonPerPage)
        if count % self.pokemonPerPage == 0 {
            self.maxPages = (count/self.pokemonPerPage)
        } else {
            self.maxPages = (count/self.pokemonPerPage) + 1
        }
        
    }
}

// MARK - PokemonStatsDelegate

extension PokedexViewController: PokemonStatsDelegate{
    func recievedPokeInfo(data: pokemon, single: Bool) {
            PokemonArray.append(data)
    }
    
    func pokemonNotFound() {
        DispatchQueue.main.async {
            self.pokemonSearchBar.placeholder = K.SearchBar.errorPlaceHolder
            self.pokemonSearchBar.text = ""
        }
        
    }
}

// MARK - TableViewDataSource

extension PokedexViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableCells.pokeDexCellIdentifier, for: indexPath) as! PokemonCell
        
        cell.pokemonNumber.text = String(PokemonArray[indexPath.row].id)
        cell.pokemonName.text = PokemonArray[indexPath.row].name
        cell.pokemonSprite.load(url: URL(string: PokemonArray[indexPath.row].sprites.front_default)!)
        
        if PokemonArray[indexPath.row].types.count == 2 {
            
            cell.type2Label.text = PokemonArray[indexPath.row].types.last?.type.name
            
            colorPicker.type = PokemonArray[indexPath.row].types.last?.type.name
            cell.type2Label.backgroundColor = colorPicker.getColorForType()
            cell.type2Label.textColor = colorPicker.getTextFontColor()
            
            cell.type2Label.isHidden = false
        } else {
            cell.type2Label.isHidden = true
        }
        cell.type1Label.text = PokemonArray[indexPath.row].types.first?.type.name
        
        colorPicker.type = PokemonArray[indexPath.row].types.first?.type.name
        cell.type1Label.backgroundColor = colorPicker.getColorForType()
        cell.type1Label.textColor = colorPicker.getTextFontColor()
        
        return cell
    }
}

// MARK - TableViewDelegate

extension PokedexViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.Segues.pokeDexToPokeStats, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK - SearchBarDelegate

extension PokedexViewController: UISearchBarDelegate{
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let search = searchBar.text {
            let pokemonToSearch = search.lowercased()
            searchForPokemonStats.fetchPokemonSearch(urlString: searchForPokemonStats.requestURLSingle + pokemonToSearch + "/")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.placeholder = K.SearchBar.initialPlaceHolder
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

// MARK - Prepare for Segue To PokemonStats

extension PokedexViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.pokeDexToPokeStats {
        }
    }
}
