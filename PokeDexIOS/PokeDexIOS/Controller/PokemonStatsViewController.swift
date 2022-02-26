//
//  PokemonStatsViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 25/02/2022.
//

import UIKit

class PokemonStatsViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var favButton: UIBarButtonItem!
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonColor: UIStackView!
    @IBOutlet weak var pokemonHeight: UILabel!
    @IBOutlet weak var pokemonWeight: UILabel!
    @IBOutlet weak var baseEXP: UILabel!
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    
    var chosenPokemon: pokemon? = nil
    
    //Colors
    var type1FontColor: UIColor = .black
    var type1Color: UIColor = .white
    var type2FontColor: UIColor = .black
    var type2Color: UIColor = .white
    
    // Bar Button OnClickActions
    @IBAction func InformationClicked(_ sender: Any) {
        performSegue(withIdentifier: K.Segues.pokeStatsToAboutMe, sender: sender)
    }
    
    @IBAction func favButtonClicked(_ sender: UIBarButtonItem) {
        switch sender.image{
        case K.BarButton.notFav:
            sender.image = K.BarButton.fav
        case K.BarButton.fav:
            sender.image = K.BarButton.notFav
        default:
            return
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pokemon = chosenPokemon{
            pokemonColor
                .backgroundColor = type1Color
            
            pokemonName.textColor = type1FontColor
            pokemonName.text = pokemon.name
            
            pokemonNumber.textColor = type1FontColor
            pokemonNumber.text = String(pokemon.id)
            
            pokemonImage.load(url: URL(string: pokemon.sprites.front_default)!)
            pokemonImage.layer.cornerRadius = 50
            pokemonImage.layer.borderWidth = 3.0
            
            pokemonWeight.text = String(pokemon.weight)
            pokemonHeight.text = String(pokemon.height)
            baseEXP.text = String(pokemon.base_experience)
            
            type1Label.layer.borderWidth = 1.0
            type1Label.layer.cornerRadius = 15.0
            type1Label.layer.masksToBounds = true
            type1Label.text = pokemon.types.first?.type.name
            type1Label.textColor = type1FontColor
            type1Label.backgroundColor  = type1Color
            
            // In case the pokemon has two types
            if pokemon.types.count > 1{
                type2Label.layer.masksToBounds = true
                type2Label.layer.borderWidth = 1.0
                type2Label.layer.cornerRadius = 15.0
                type2Label.isHidden = false
                
                type2Label.text = pokemon.types.last?.type.name
                type2Label.textColor = type2FontColor
                type2Label.backgroundColor  = type2Color

            // Pokemon only has 1 type
            } else {
                type2Label.isHidden = true
            }
        }
    }
    
}
