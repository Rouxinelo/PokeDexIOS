//
//  PokemonCell.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var pokemonSprite: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    var colorPicker = TypeColorManager()
    
    var displayPokemon: pokemon?
    
    func loadPokeInfo(pokemon: pokemon){
        pokemonNumber.text = String(pokemon.id)
        pokemonName.text = pokemon.name
        pokemonSprite.load(url: URL(string: pokemon.sprites.front_default)!)
        if pokemon.types.count == 2 {
            type2Label.text = pokemon.types.last?.type.name
            colorPicker.type = pokemon.types.last?.type.name
            type2Label.backgroundColor = colorPicker.getColorForType()
            type2Label.textColor = colorPicker.getTextFontColor()
            type2Label.alpha = 1
        } else {
            type2Label.alpha = 0
        }
        type1Label.text = pokemon.types.first?.type.name
        
        colorPicker.type = pokemon.types.first?.type.name
        type1Label.backgroundColor = colorPicker.getColorForType()
        type1Label.textColor = colorPicker.getTextFontColor()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        stackView.layer.borderWidth = 1.0
        
        pokemonSprite.layer.borderWidth = 1.0
        
        type1Label.layer.borderWidth = 1.0
        type1Label.layer.cornerRadius = 15.0
        type2Label.layer.borderWidth = 1.0
        type2Label.layer.cornerRadius = 15.0
    }
    
}
