//
//  GamesViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 25/03/2022.
//

import UIKit

class GamesViewController: UIViewController {
    
    // MARK: - IBOutlers
    
    @IBOutlet weak var pokemonColor: UIStackView!
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var gameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Local Variables
    
    var colorPicker = TypeColorManager()
    
    var chosenPokemon: Pokemon?
    
    // MARK: - Button Onclick Actions
    
    @IBAction func homeButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
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
    
    // MARK: - Pokemon is not in any game
    
    func noGames() {
        
        loadBlur()
        
        let alertController = UIAlertController(title: "Oh No!", message:
                                                    "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Return", style: .default, handler:  { action -> Void in
            self.returnToPreviousScreen()
        }))
        alertController.message = chosenPokemon!.name.capitalizingFirstLetter() + " does not feature in any game."
        
        self.present(alertController, animated: true, completion: nil)
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
            
            gameLabel.textColor = colorPicker.getTextFontColor()
            
        }
    }
    
    // MARK: - Other functions
    
    func loadBlur() {
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.prominent))
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
    }
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        if let pokemon = chosenPokemon {
            
            if pokemon.game_indices.count == 0 {
                noGames()
            }
        }
        
        defineSwipeGesture()
        
        loadPokemon()
    }
}

extension GamesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pokemon = chosenPokemon {
            return pokemon.game_indices.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableCells.gameCellIdentifier, for: indexPath) as! GameCell
        
        if let pokemon = chosenPokemon {
            cell.gameName.text = pokemon.game_indices[indexPath.row].version.name
            cell.setGame(name: cell.gameName.text!)
        }
        return cell
    }
    
    
}
