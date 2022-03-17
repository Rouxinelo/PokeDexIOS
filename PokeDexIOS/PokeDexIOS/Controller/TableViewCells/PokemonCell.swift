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
    
    var displayPokemon: Pokemon?
    
    // MARK: - Other functions
    
    func loadPokeInfo(pokemon: Pokemon) {
        pokemonNumber.text = String(pokemon.id)
        pokemonName.text = pokemon.name.capitalizingFirstLetter()
        if let image = pokemon.sprites.front_default {
            pokemonSprite.load(url: URL(string: image)!)
        } else {
            pokemonSprite.image = UIImage(named: "noSprite")
        }
        
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
    
    
    func setStyle() {
        
        stackView.layer.borderWidth = K.TableCells.strokeWidth
        stackView.layer.cornerRadius = K.TableCells.borderRadius
        stackView.layer.cornerCurve = .continuous

        type1Label.layer.borderWidth = K.TableCells.strokeWidth
        type1Label.layer.cornerRadius = K.TableCells.borderRadius
        type2Label.layer.borderWidth = K.TableCells.strokeWidth
        type2Label.layer.cornerRadius = K.TableCells.borderRadius
        
    }
    
    // MARK: - awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setStyle()
    }
    
}
