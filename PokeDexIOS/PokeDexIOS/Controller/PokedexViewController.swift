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
    
    let searchGroup = DispatchGroup()
    let searchSemaphore = DispatchSemaphore(value: 0)
    
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
    
    var pokemonArray = [Pokemon]()
    
    // MARK: - Gesture Recognizers
    
    func defineSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // MARK: - Button Onclick Actions
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func favouritesButtonClicked(_ sender: UIBarButtonItem) {
        
        loadingIndicator()
        
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
    
    func buttonsEnabler(enabler: Bool) {
        nextPageButton.isEnabled = enabler
        lastPageButton.isEnabled = enabler
        prevPageButton.isEnabled = enabler
        firstPageButton.isEnabled = enabler
        favouritesBarButton.isEnabled = enabler
    }
    
    @IBAction func pageButtonPressed(_ sender: UIButton) {
        
        loadingIndicator()
        
        buttonsEnabler(enabler: false)
        if sender == prevPageButton {
            currentPage -= 1
            searchPokemons(filter: Filter.all.rawValue)
            
        } else if sender == nextPageButton {
            currentPage+=1
            searchPokemons(filter: Filter.all.rawValue)
            
        } else if sender == firstPageButton {
            currentPage = 1
            searchPokemons(filter: Filter.all.rawValue)
            
        } else if sender == lastPageButton {
            currentPage = maxPages
            searchPokemons(filter: Filter.all.rawValue)
        }
        checkButton()
        
        
        pageLabel.text = String(currentPage)
    }
    
    // MARK: - Network Requests
    
    func getCount() {
        
        networkLayer.requestAPI(api: API.GetPokedex("0", "1"), parameters: API.GetPokedex("0", "1").params, headers: API.GetPokedex("0", "1").header, completion: { [weak self] result in
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
        
        networkLayer.requestAPI(api: API.GetPokedex("0", String(maxPokemon)), parameters: API.GetPokedex("0", String(maxPokemon)).params, headers: API.GetPokedex("0", String(maxPokemon)).header, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                if let results = results {
                    
                    let pokedex = self.parser.parsePokeData(Data: results)
                    
                    for pokemon in pokedex!.results {
                        self.pokeNameArray.append(pokemon.name)
                    }
                    self.searchPokemons(filter: Filter.all.rawValue)
                }
                
            case .error(let error):
                print(error)
            }
        })
    }
    
    func requestPokemon(name: String) {
        
        self.networkLayer.requestAPI(api: API.GetPokemonInfo(name), parameters: API.GetPokemonInfo(name).params, headers: API.GetPokemonInfo(name).header, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                if let results = results {
                    
                    let pokemon = self.parser.parsePokemon(Data: results)
                    if let pokemon = pokemon{
                        self.pokemonArray.append(pokemon)
                    }
                    self.searchGroup.leave()
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
                if i==pokeNameArray.count {
                    break
                }
                searchSemaphore.signal()
                self.searchGroup.enter()
                self.requestPokemon(name: self.pokeNameArray[i])
            }
            searchGroup.notify(queue: .main) {
                self.setupPageAfterRequest()
            }
            
        } else if filter == Filter.favourites.rawValue {
            for pokemon in favPokeNameArray {
                searchSemaphore.signal()
                self.searchGroup.enter()
                requestPokemon(name: pokemon)
                
                searchGroup.notify(queue: .main) {
                    self.setupPageAfterRequest()
                }
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Core data functions
    
    func loadFavArray() {
        favPokeNameArray.removeAll()
        
        loadFavPokemon()
        for item in favPokemon {
            favPokeNameArray.append(item.name!)
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
    
    func setupPageAfterRequest() {
        self.pokemonArray = self.sortArray(array: self.pokemonArray)
        self.searchSemaphore.wait()
        self.tableView.reloadData()
        self.buttonsEnabler(enabler: true)
        removeLoading()
    }
    
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
    
    func loadingIndicator(){
        let alert = UIAlertController(title: nil, message: "Loading Pokémon...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func removeLoading(){
        dismiss(animated: false, completion: nil)
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCount()
        
        pokemonSearchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        setStyle()
        
        defineSwipeGesture()
        
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
            searchSinglePokemon(name: pokemonToSearch)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.placeholder = K.SearchBar.initialPlaceHolder
    }
    
    func searchSinglePokemon(name: String) {
        
        self.networkLayer.requestAPI(api: API.GetPokemonInfo(name), parameters: API.GetPokemonInfo(name).params, headers: API.GetPokemonInfo(name).header, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                if let results = results {
                    
                    let pokemon = self.parser.parsePokemon(Data: results)
                    if let pokemon = pokemon{
                        self.selectedPokemon = pokemon
                        self.performSegue(withIdentifier: K.Segues.pokeDexToPokeStats, sender: self)
                    }
                }
                
            case .error(let error):
                self.pokemonSearchBar.text = ""
                self.pokemonSearchBar.placeholder = K.SearchBar.errorPlaceHolder
                print(error)
            }
        })
        
    }
}

// MARK: - Prepare for Segue To PokemonStats

extension PokedexViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.pokeDexToPokeStats {
            
            if let VC = segue.destination as? PokemonStatsViewController {
                VC.delegate = self
                if let pokemonChosen = selectedPokemon {
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
                if pokemon.name == pokemonArray[i].name {
                    pokemonArray.remove(at: i)
                    tableView.reloadData()
                    break
                }
            }
        }
        tableView.reloadData()
    }
}
