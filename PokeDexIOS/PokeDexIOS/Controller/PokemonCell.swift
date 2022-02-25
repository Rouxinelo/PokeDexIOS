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
    
    @IBOutlet weak var strokeLabel: UILabel!
    
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        strokeLabel.layer.borderWidth = 1.0

        pokemonSprite.layer.borderWidth = 1.0
        
        type1Label.layer.borderWidth = 1.0
        type1Label.layer.cornerRadius = 15.0
        type2Label.layer.borderWidth = 1.0
        type2Label.layer.cornerRadius = 15.0
    }

}
