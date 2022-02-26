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
    var fontColor: UIColor = .black
    var backgroundColor: UIColor = .white
    
    // Bar Button OnClickAction
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
            print("NO IMAGE")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pokemon = chosenPokemon{
            pokemonColor
                .backgroundColor = backgroundColor
            
            pokemonName.textColor = fontColor
            pokemonName.text = pokemon.name
            
            pokemonNumber.textColor = fontColor
            pokemonNumber.text = String(pokemon.id)
            
            pokemonImage.load(url: URL(string: pokemon.sprites.front_default)!)
            pokemonImage.layer.cornerRadius = 50
            pokemonImage.layer.borderWidth = 3.0
        }
        // Do any additional setup after loading the view.
    }
    

}
