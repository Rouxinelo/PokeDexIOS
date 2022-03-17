//
//  MovesAndAbilitiesViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 10/03/2022.
//

import UIKit

class MovesAndAbilitiesViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var moveTableCell: UITableView!
    @IBOutlet weak var pokemonColor: UIStackView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var howLabel: UILabel!
    
    // MARK: - Local Variables
    
    let networkLayer = NetworkLayer()
    let parser = ParseData()

    var chosenPokemon: Pokemon?
    
    var chosenMove: PokemonMove?
    var chosenMoveName: String?
    
    var colorPicker = TypeColorManager()
    
    // MARK: - Button Onclick Actions
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        returnToPreviousScreen()
    }
    
    // MARK: - Navigation functions
    
    func returnToPreviousScreen(){
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Gesture Handlers
    
    func defineSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            returnToPreviousScreen()
        }
    }
    
    // MARK: - Request move Info
    
    func requestMove(moveURL: String) {
        self.networkLayer.requestAPI(api: API.GetMove(moveURL), parameters: nil, headers: K.headers.pokeApi, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                if let results = results {
                    
                    let pokemonMove = self.parser.parsePokemonMove(Data: results)
                    if let pokemonMove = pokemonMove {
                        self.chosenMove = pokemonMove
                        self.performSegue(withIdentifier: K.Segues.movesAndAbilitiesToMoveStats, sender: self)
                    }
                }
            case .error(let error):
                print(error)
            }
        })
    }
    
    
    // MARK: - Load Pokemon Info
    
    func loadPokemon(){
        if let pokemon = chosenPokemon {
            
            colorPicker.type = pokemon.types.first?.type.name
            
            pokemonColor.backgroundColor = colorPicker.getColorForType()
            
            
            pokemonColor.clipsToBounds = true
            pokemonColor.layer.cornerRadius = 28
            pokemonColor.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            pokemonName.text = pokemon.name.capitalizingFirstLetter()
            pokemonName.textColor = colorPicker.getTextFontColor()
            
            pokemonNumber.text = String(pokemon.id)
            pokemonNumber.textColor = colorPicker.getTextFontColor()
            
            movesLabel.textColor = colorPicker.getTextFontColor()
            howLabel.textColor = colorPicker.getTextFontColor()
            
        }
    }
    
    // MARK: - Other Functions
    
    func sortArray(array: [PossibleMove]) -> [PossibleMove] {
        return array.sorted { $0.move.name < $1.move.name }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pokemon = chosenPokemon {
            chosenPokemon!.moves = sortArray(array: pokemon.moves)
        }
        
        moveTableCell.dataSource = self
        moveTableCell.delegate = self
        
        loadPokemon()
        
        defineSwipeGesture()
        
    }
    
}

// MARK: - Table View Data Source

extension MovesAndAbilitiesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pokemon = chosenPokemon {
            return pokemon.moves.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableCells.moveCellIdentifier, for: indexPath) as! MoveCell
        if let pokemon = chosenPokemon {
            cell.loadMove(move: pokemon.moves[indexPath.row])
        }
        return cell
    }
}

// MARK: - Table View Delegate

extension MovesAndAbilitiesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let pokemon = chosenPokemon {
            requestMove(moveURL: pokemon.moves[indexPath.row].move.url)
            chosenMoveName = pokemon.moves[indexPath.row].move.name
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Prepare For Segue

extension MovesAndAbilitiesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.movesAndAbilitiesToMoveStats {
            
            if let VC = segue.destination as? MoveStatsViewController {
                if let move = chosenMove {
                    VC.chosenMove = move
                    VC.moveName = chosenMoveName
                }
            }
        }
    }
}
