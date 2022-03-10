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
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var moveTableCell: UITableView!
    @IBOutlet weak var pokemonColor: UIStackView!
    @IBOutlet weak var imageTextLabel: UILabel!
    
    // MARK: - Local Variables
    
    var chosenPokemon: pokemon?

    var moveArray =  [possibleMove]()
    
    var colorPicker = TypeColorManager()
    
    // MARK: - Navigation functions
    
    func returnToPreviousScreen(){
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Gesture Handlers
    
    func defineSwipeGesture(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer){
        if gesture.direction == .right {
            returnToPreviousScreen()
        }
    }
    
    // MARK: - Load Pokemon Info
    
    func loadPokemon(){
        if let pokemon = chosenPokemon {
            
            colorPicker.type = pokemon.types.first?.type.name
            
            pokemonColor.backgroundColor = colorPicker.getColorForType()
            
            pokemonName.text = pokemon.name.capitalizingFirstLetter()
            pokemonName.textColor = colorPicker.getTextFontColor()
            
            pokemonNumber.text = String(pokemon.id)
            pokemonNumber.textColor = colorPicker.getTextFontColor()
            
            pokemonImage.load(url: URL(string: pokemon.sprites.front_default)!)
            pokemonImage.layer.borderWidth = K.StatsScreen.spriteStrokeWidth
            pokemonImage.layer.cornerRadius = K.StatsScreen.spriteRadius
            
            imageTextLabel.textColor = colorPicker.getTextFontColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moveTableCell.dataSource = self
        
        loadPokemon()
        
        defineSwipeGesture()
    }
    
}

// MARK: - Table View Data Source

extension MovesAndAbilitiesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moveArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableCells.moveCellIdentifier, for: indexPath) as! MoveCell
        
        cell.loadMove(move: moveArray[indexPath.row])
        
        return cell
    }
}
