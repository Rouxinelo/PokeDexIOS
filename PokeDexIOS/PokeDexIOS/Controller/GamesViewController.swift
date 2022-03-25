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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defineSwipeGesture()
        
        loadPokemon()
        
    }
    
    
    
}
