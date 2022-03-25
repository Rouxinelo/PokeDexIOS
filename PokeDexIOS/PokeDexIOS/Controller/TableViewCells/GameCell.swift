//
//  GameCell.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 25/03/2022.
//

import UIKit

class GameCell: UITableViewCell {

    @IBOutlet weak var gameName: UILabel!
    
    func setGame(name: String) {
        gameName.text = name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
