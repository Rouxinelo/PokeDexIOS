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
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Button Outlets
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var prevPageButton: UIButton!
    @IBOutlet weak var firstPageButton: UIButton!
    @IBOutlet weak var lastPageButton: UIButton!
    @IBOutlet weak var favouritesBarButton: UIBarButtonItem!
    
    // Content Stack View
    @IBOutlet weak var contentStackView: UIStackView!
    
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
    
    var selectedPokemon: Pokemon? =  nil
    var pokemonPerPage = K.pokemonPerPage
    
    // Array of pokemons marked as favourite
    var favPokemon = [FavPokemon]()
    
    // Variables used for pagination
    var maxPokemon: Int = 0
    var maxPages: Int = 0
    var currentPage: Int = 1
    
    // Arrays that store pokemon data
    var urlArray = [String]()
    var urlFavArray = [String]()
    var pokemonArray = [Pokemon]()
    
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
            sender.image = K.BarButton.fav
            paginationStackView.isHidden = true
            loadFavArray()
            
            searchPokemons(filter: "FAV")
            
        case "Favourites":
            sender.title = "All"
            sender.image = K.BarButton.notFav
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
        
        pokemonArray.removeAll()
        
        if filter == "ALL" {
            
            let indices = getIndicesOfPage(elementsPerPage: pokemonPerPage)
            
            for i in indices[0]...indices[1]{
                if i==urlArray.count{
                    break
                }
                self.searchForPokemonStats.requestURL = urlArray[i]
                self.searchForPokemonStats.fetchData()
            }
            
        } else if filter == "FAV" {
            for pokemon in urlFavArray{
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
        urlFavArray.removeAll()
        
        loadFavPokemon()
        for item in favPokemon{
            urlFavArray.append(K.baseSinglePokemonURL + item.name!)
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
        }
    }
    
    // MARK: - Other functions
    
    func setSliderData(Pagevalue: Int, thumbImageName: String){
        pokemonPerPageSlider.value = Float(Pagevalue)
        pokemonPerPageSlider.setThumbImage(UIImage(named: thumbImageName), for: .normal)
        pokemonPerPageLabel.text = String(Pagevalue)
    }
    
    func setStyle(){
        
        contentStackView.layer.cornerRadius = K.TableCells.borderRadius
        
        setSliderData(Pagevalue: K.pokemonPerPage, thumbImageName: K.sliderImage)
        
    }
    
    func firstRequest(){
        
        searchForPokemonUrls.fetchData(op: "COUNT")
        
        checkButton()
        
        searchForPokemonUrls.requestURL = searchForPokemonUrls.requestURL + String(maxPokemon) + K.URLS.searchOffSet
        
        DispatchQueue.main.async {
            self.searchForPokemonUrls.fetchData(op: "LIST")
        }
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchForPokemonUrls.delegate = self
        searchForPokemonStats.delegate = self
        pokemonSearchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        setStyle()
        
        firstRequest()
    }
}

// MARK: - PokeRequestDelegate

extension PokedexViewController: PokeRequestDelegate{
    func recievedPokeList(data: PokeData) {
        for res in data.results{
            urlArray.append(res.url)
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
    func recievedPokeInfo(data: Pokemon, single: Bool) {
        if single{
            selectedPokemon = data
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: K.Segues.pokeDexToPokeStats, sender: self)
            }
        } else {
            pokemonArray.append(data)
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
        return pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row > pokemonArray.count-1){
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableCells.pokeDexCellIdentifier, for: indexPath) as! PokemonCell
        
        cell.loadPokeInfo(pokemon: pokemonArray[indexPath.row])
        
        cell.layoutIfNeeded()
        
        return cell
    }
}

// MARK: - TableViewDelegate

extension PokedexViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPokemon = pokemonArray[indexPath.row]
        
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
                VC.delegate = self
                if let pokemonChosen = selectedPokemon{
                    VC.chosenPokemon = pokemonChosen
                }
            }
        }
    }
}

// MARK: - PokemonStatsViewControllerDelegate

extension PokedexViewController: PokemonStatsViewControllerDelegate{
    
    func didRemoveFromFavourites(pokemon: Pokemon) {
        if favouritesBarButton.title == "Favourites"{
            for i in 0..<pokemonArray.count{
                if pokemon.name == pokemonArray[i].name{
                    pokemonArray.remove(at: i)
                    tableView.reloadData()
                    break
                }
            }
        }
    }
}
