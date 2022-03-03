//
//  ViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import UIKit
import CoreData

class PokedexViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    // Button Outlets
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var prevPageButton: UIButton!
    @IBOutlet weak var firstPageButton: UIButton!
    @IBOutlet weak var lastPageButton: UIButton!
    @IBOutlet weak var favouritesBarButton: UIBarButtonItem!
    
    // Text Label Outlets
    @IBOutlet weak var pageLabel: UILabel!
    
    // Table View Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Search Bar Outlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    // Buttons Stack View
    @IBOutlet weak var paginationStackView: UIStackView!
    
    // Slider outlet
    @IBOutlet weak var pokemonPerPageSlider: UISlider!
    @IBOutlet weak var pokemonPerPageLabel: UILabel!
    
    // MARK: - Local variables
    
    // Context for Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedPokemon: pokemon? =  nil
    var pokemonPerPage = K.pokemonPerPage
    
    // Array of pokemons marked as favourite
    var favPokemon = [FavPokemon]()
    
    // Variables used for pagination
    var maxPokemon: Int = 0
    var maxPages: Int = 0
    var currentPage: Int = 1
    
    // Arrays that store pokemon data
    var URLarray = [String]()
    var URLFavArray = [String]()
    var PokemonArray = [pokemon]()
    
    var searchForPokemonUrls = PokeRequest()
    var searchForPokemonStats = PokemonStats()
    
    // MARK: - Button Onclick Actions
    
    @IBAction func InformationClicked(_ sender: Any) {
        performSegue(withIdentifier: K.Segues.pokeDexToAboutMe, sender: sender)
    }
    
    @IBAction func favouritesButtonClicked(_ sender: UIBarButtonItem) {
        switch sender.title{
        case "All":
            sender.title = "Favourites"
            paginationStackView.isHidden = true
            
            loadFavArray()
            
            searchPokemons(filter: "FAV")
            
        case "Favourites":
            sender.title = "All"
            paginationStackView.isHidden = false
            
            searchPokemons(filter: "ALL")
        default:
            print("error")
        }
    }
    
    // MARK: - Slider onclick action
    
    @IBAction func pokemonPerPageValueChanged(_ sender: UISlider) {
        if Int(pokemonPerPageSlider.value) != pokemonPerPage {
            pokemonPerPageLabel.text = String(Int(pokemonPerPageSlider.value))
            pokemonPerPage = Int(pokemonPerPageSlider.value)
            recievedPokeCount(count: maxPokemon)
            pageLabel.text = String(currentPage)
            searchPokemons(filter: "ALL")
            checkButton()
        }
    }
    
    // MARK: - Pagination
    
    func getIndicesOfPage(elementsPerPage: Int) -> [Int]{
        return [(currentPage-1)*elementsPerPage, elementsPerPage*(currentPage-1) + (elementsPerPage-1)]
    }
    
    func buttonVisibility(prev: Bool, next: Bool){
        nextPageButton.isHidden = next
        lastPageButton.isHidden = next
        prevPageButton.isHidden = prev
        firstPageButton.isHidden = prev
    }
    
    func checkButton(){
        if currentPage == 1 {
            buttonVisibility(prev: true, next: false)
        } else if currentPage == maxPages {
            buttonVisibility(prev: false, next: true)
        } else {
            buttonVisibility(prev: false, next: false)
        }
    }
    
    @IBAction func pageButtonPressed(_ sender: UIButton) {
        if sender == prevPageButton{
            currentPage -= 1
            checkButton()
            searchPokemons(filter: "ALL")
        } else if sender == nextPageButton {
            currentPage+=1
            checkButton()
            searchPokemons(filter: "ALL")
        } else if sender == firstPageButton{
            currentPage = 1
            checkButton()
            searchPokemons(filter: "ALL")
        } else if sender == lastPageButton{
            currentPage = maxPages
            checkButton()
            searchPokemons(filter: "ALL")
        }
        pageLabel.text = String(currentPage)
    }
    
    // MARK: - Function that requests for pokemon stats data
    
    func searchPokemons(filter: String){
        
        PokemonArray.removeAll()
        
        if filter == "ALL" {
            
            let indices = getIndicesOfPage(elementsPerPage: pokemonPerPage)
            
            for i in indices[0]...indices[1]{
                if i==URLarray.count{
                    break
                }
                self.searchForPokemonStats.requestURL = URLarray[i]
                self.searchForPokemonStats.fetchData()
            }
            
        } else if filter == "FAV" {
            for pokemon in URLFavArray{
                self.searchForPokemonStats.requestURL = pokemon
                self.searchForPokemonStats.fetchData()
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Core data functions
    
    func loadFavArray(){
        URLFavArray.removeAll()
        
        loadFavPokemon()
        for item in favPokemon{
            URLFavArray.append(K.baseSinglePokemonURL + item.name!)
        }
    }
    
    func loadFavPokemon(){
        let request: NSFetchRequest<FavPokemon> = FavPokemon.fetchRequest()
        do {
            
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            let sortDescriptors = [sortDescriptor]
            request.sortDescriptors = sortDescriptors
            
            favPokemon = try context.fetch(request)
        } catch {
            print ("error loading")
        }
    }
    
    // MARK: - Other functions
    
    override func didMove(toParent parent: UIViewController?){
        if favouritesBarButton.title == "Favourites"{
            loadFavArray()
            searchPokemons(filter: "FAV")
        }
    }
    
    func setSliderData(Pagevalue: Int, thumbImageName: String){
        pokemonPerPageSlider.value = Float(Pagevalue)
        pokemonPerPageSlider.setThumbImage(UIImage(named: thumbImageName), for: .normal)
        pokemonPerPageLabel.text = String(Pagevalue)
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSliderData(Pagevalue: K.pokemonPerPage, thumbImageName: K.sliderImage)
        
        searchForPokemonUrls.delegate = self
        searchForPokemonStats.delegate = self
        pokemonSearchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        searchForPokemonUrls.fetchData(op: "COUNT")
        
        checkButton()
        
        searchForPokemonUrls.requestURL = searchForPokemonUrls.requestURL + String(maxPokemon) + K.URLS.searchOffSet
        
        DispatchQueue.main.async {
            self.searchForPokemonUrls.fetchData(op: "LIST")
        }
    }
}

// MARK: - PokeRequestDelegate

extension PokedexViewController: PokeRequestDelegate{
    func recievedPokeList(data: pokeData) {
        for res in data.results{
            URLarray.append(res.url)
        }
        
        searchPokemons(filter: "ALL")
        
        DispatchQueue.main.async {
            self.checkButton()
        }
    }
    
    func recievedPokeCount(count: Int) {
        maxPokemon = count
        currentPage = 1
        if count % self.pokemonPerPage == 0 {
            self.maxPages = (count/self.pokemonPerPage)
        } else {
            self.maxPages = (count/self.pokemonPerPage) + 1
        }
    }
}

// MARK: - PokemonStatsDelegate

extension PokedexViewController: PokemonStatsDelegate{
    func recievedPokeInfo(data: pokemon, single: Bool) {
        if single{
            selectedPokemon = data
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: K.Segues.pokeDexToPokeStats, sender: self)
            }
        } else {
            PokemonArray.append(data)
        }
    }
    
    func pokemonNotFound() {
        DispatchQueue.main.async {
            self.pokemonSearchBar.placeholder = K.SearchBar.errorPlaceHolder
            self.pokemonSearchBar.text = ""
        }
    }
}

// MARK: - TableViewDataSource

extension PokedexViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row > PokemonArray.count-1){
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableCells.pokeDexCellIdentifier, for: indexPath) as! PokemonCell
        
        cell.loadPokeInfo(pokemon: PokemonArray[indexPath.row])
        
        cell.layoutIfNeeded()
        
        return cell
    }
}

// MARK: - TableViewDelegate

extension PokedexViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPokemon = PokemonArray[indexPath.row]
        
        performSegue(withIdentifier: K.Segues.pokeDexToPokeStats, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SearchBarDelegate

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

// MARK: - Prepare for Segue To PokemonStats

extension PokedexViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.pokeDexToPokeStats {
            if let VC = segue.destination as? PokemonStatsViewController{
                
                if let pokemonChosen = selectedPokemon{
                    VC.chosenPokemon = pokemonChosen
                }
            }
        }
    }
}

// MARK: - Load Image From URL

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

// MARK: - Uppercase first letter of a String

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
