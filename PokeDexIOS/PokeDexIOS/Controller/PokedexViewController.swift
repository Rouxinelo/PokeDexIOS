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
    let requestGroup = DispatchGroup()
    let sem = DispatchSemaphore(value: 0)

    let networkLayer = NetworkLayer()
    let parser = ParseData()
    
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
    var pokeNameArray = [String]()
    var favPokeNameArray = [String]()
    
    var urlArray = [String]()
    var urlFavArray = [String]()
    var pokemonArray = [Pokemon]()
    
    var searchForPokemonStats = PokemonStats()
    
    // MARK: - Button Onclick Actions
    
    @IBAction func InformationClicked(_ sender: Any) {
        performSegue(withIdentifier: K.Segues.pokeDexToAboutMe, sender: sender)
    }
    
    @IBAction func favouritesButtonClicked(_ sender: UIBarButtonItem) {
        switch sender.title {
        case "All":
            sender.title = "Favourites"
            sender.image = K.BarButton.fav
            paginationStackView.isHidden = true
            loadFavArray()
            
            searchPokemons(filter: Filter.favourites.rawValue)
            
        case "Favourites":
            sender.title = "All"
            sender.image = K.BarButton.notFav
            paginationStackView.isHidden = false
            searchPokemons(filter: Filter.all.rawValue)
        default:
            print("error")
        }
    }
    
    // MARK: - Slider onclick action
    
    @IBAction func pokemonPerPageValueChanged(_ sender: UISlider) {
        if Int(pokemonPerPageSlider.value) != pokemonPerPage {
            pokemonPerPageLabel.text = String(Int(pokemonPerPageSlider.value))
            pokemonPerPage = Int(pokemonPerPageSlider.value)
            checkMaxPokemonAndPages(count: maxPokemon)
            pageLabel.text = String(currentPage)
            searchPokemons(filter: Filter.all.rawValue)
            checkButton()
        }
    }
    
    // MARK: - Pagination
    
    func checkMaxPokemonAndPages(count: Int) {
        maxPokemon = count
        currentPage = 1
        if count % self.pokemonPerPage == 0 {
            self.maxPages = (count/self.pokemonPerPage)
        } else {
            self.maxPages = (count/self.pokemonPerPage) + 1
        }
    }
    
    func getIndicesOfPage(elementsPerPage: Int) -> [Int] {
        return [(currentPage-1)*elementsPerPage, elementsPerPage*(currentPage-1) + (elementsPerPage-1)]
    }
    
    func buttonVisibility(prev: Bool, next: Bool) {
        nextPageButton.isHidden = next
        lastPageButton.isHidden = next
        prevPageButton.isHidden = prev
        firstPageButton.isHidden = prev
    }
    
    func checkButton() {
        if currentPage == 1 {
            buttonVisibility(prev: true, next: false)
        } else if currentPage == maxPages {
            buttonVisibility(prev: false, next: true)
        } else {
            buttonVisibility(prev: false, next: false)
        }
    }
    
    @IBAction func pageButtonPressed(_ sender: UIButton) {

        if sender == prevPageButton {
            currentPage -= 1
            self.checkButton()
            searchPokemons(filter: Filter.all.rawValue)

        } else if sender == nextPageButton {
            currentPage+=1
            self.checkButton()
            searchPokemons(filter: Filter.all.rawValue)

        } else if sender == firstPageButton {
            currentPage = 1
            self.checkButton()
            searchPokemons(filter: Filter.all.rawValue)
            
        } else if sender == lastPageButton {
            currentPage = maxPages
            self.checkButton()
            searchPokemons(filter: Filter.all.rawValue)
        }
        
        

        pageLabel.text = String(currentPage)
    }
    
    // MARK: - Function that requests for pokemon stats data
    
    func requestPokemon(name: String) {
        
        self.networkLayer.requestAPI(api: API.GetPokemonInfo(name), parameters: nil, headers: K.headers.pokeApi, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                if let results = results {
                    
                    let pokemon = self.parser.parsePokemon(Data: results)
                    if let pokemon = pokemon{
                        self.pokemonArray.append(pokemon)
                    }
                    self.requestGroup.leave()
                }
                
            case .error(let error):
                
                print(error)
            }
        })
        
    }
    
    func searchPokemons(filter: String) {
        pokemonArray.removeAll()
        
        if filter == Filter.all.rawValue {
            
            let indices = getIndicesOfPage(elementsPerPage: pokemonPerPage)
            
            for i in indices[0]...indices[1]{
                if i==urlArray.count {
                    break
                }
                    sem.signal()
                    self.requestGroup.enter()
                    self.requestPokemon(name: self.pokeNameArray[i])
            }
            requestGroup.notify(queue: .main) {
                self.pokemonArray = self.sortArray(array: self.pokemonArray)
                self.sem.wait()
                self.tableView.reloadData()
            }
            
        } else if filter == Filter.favourites.rawValue {
            for pokemon in urlFavArray {
                self.searchForPokemonStats.requestURL = pokemon
                self.searchForPokemonStats.fetchData()
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Core data functions
    
    func loadFavArray() {
        urlFavArray.removeAll()
        
        loadFavPokemon()
        for item in favPokemon {
            urlFavArray.append(API.GetPokemonInfo(item.name!).path)
        }
    }
    
    func loadFavPokemon() {
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
    
    func sortArray(array: [Pokemon]) -> [Pokemon] {
        return array.sorted { $0.id < $1.id }
    }
    
    func setSliderData(Pagevalue: Int, thumbImageName: String) {
        pokemonPerPageSlider.isContinuous = false
        pokemonPerPageSlider.value = Float(Pagevalue)
        pokemonPerPageSlider.setThumbImage(UIImage(named: thumbImageName), for: .normal)
        pokemonPerPageLabel.text = String(Pagevalue)
    }
    
    func setStyle() {
        
        contentStackView.layer.cornerRadius = K.TableCells.borderRadius
        
        setSliderData(Pagevalue: K.pokemonPerPage, thumbImageName: K.sliderImage)
        
    }
    
    func getCount() {
        
        networkLayer.requestAPI(api: API.GetPokedex("0", "1"), parameters: nil, headers: K.headers.pokeApi, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                if let results = results {
                    
                    let pokedex = self.parser.parsePokeData(Data: results)
                    
                    self.checkMaxPokemonAndPages(count: pokedex!.count)
                    
                    self.checkButton()
                    
                    self.getUrls()
                    
                }
                
            case .error(let error):
                
                print(error)
            }
        })
        
    }
    
    func getUrls() {
        
        networkLayer.requestAPI(api: API.GetPokedex("0", String(maxPokemon)), parameters: nil, headers: K.headers.pokeApi, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                if let results = results {
                    
                    let pokedex = self.parser.parsePokeData(Data: results)
                    
                    for pokemon in pokedex!.results {
                        self.pokeNameArray.append(pokemon.name)
                        self.urlArray.append(pokemon.url)
                    }
                    
                    self.searchPokemons(filter: Filter.all.rawValue)
                    
                }
                
            case .error(let error):
                print(error)
            }
        })
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getCount()
        
        searchForPokemonStats.delegate = self
        pokemonSearchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        setStyle()
    }
}

// MARK: - PokemonStatsDelegate

extension PokedexViewController: PokemonStatsDelegate {
    func recievedPokeInfo(data: Pokemon, single: Bool) {
        if single {
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

extension PokedexViewController: UITableViewDataSource {
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

extension PokedexViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPokemon = pokemonArray[indexPath.row]
        
        performSegue(withIdentifier: K.Segues.pokeDexToPokeStats, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SearchBarDelegate

extension PokedexViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let search = searchBar.text {
            let pokemonToSearch = search.lowercased()
            searchForPokemonStats.fetchPokemonSearch(urlString: API.GetPokemonInfo(pokemonToSearch).path)
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
            
            if let VC = segue.destination as? PokemonStatsViewController {
                VC.delegate = self
                if let pokemonChosen = selectedPokemon{
                    VC.chosenPokemon = pokemonChosen
                }
            }
        }
    }
}

// MARK: - PokemonStatsViewControllerDelegate

extension PokedexViewController: PokemonStatsViewControllerDelegate {
    
    func didRemoveFromFavourites(pokemon: Pokemon) {
        if favouritesBarButton.title == "Favourites" {
            for i in 0..<pokemonArray.count{
                if pokemon.name == pokemonArray[i].name{
                    pokemonArray.remove(at: i)
                    tableView.reloadData()
                    break
                }
            }
        }
        tableView.reloadData()
    }
}
