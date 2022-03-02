//
//  PokemonCell.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var pokemonSprite: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Local Variables
    var colorPicker = TypeColorManager()
    
    var displayPokemon: pokemon?
    
    // MARK: - Other functions
    
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
    
    // MARK: - awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        stackView.layer.borderWidth = K.TableCells.strokeWidth
        
        pokemonSprite.layer.borderWidth = K.TableCells.strokeWidth
        
        type1Label.layer.borderWidth = K.TableCells.strokeWidth
        type1Label.layer.cornerRadius = K.TableCells.borderRadius
        type2Label.layer.borderWidth = K.TableCells.strokeWidth
        type2Label.layer.cornerRadius = K.TableCells.borderRadius
    }
    
}
