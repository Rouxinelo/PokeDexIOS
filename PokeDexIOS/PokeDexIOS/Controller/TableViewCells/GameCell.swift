//
//  GameCell.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 25/03/2022.
//

import UIKit

class GameCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var gameName: UILabel!
    
    // MARK: - Other Functions
    
    func gameNameSetup(name: String) -> String {
        switch name {
        case "firered":
            return "Fire Red"
        case "leafgreen":
            return "Leaf Green"
        case "heartgold":
            return "Heart Gold"
        case "soulsilver":
            return "Soul Silver"
        case "black-2":
            return "Black 2"
        case "white-2":
            return "White 2"
        default:
            return name.capitalizingFirstLetter()
        }
    }
    
    func setGame(name: String) {
        gameName.text = "Pokemon " + gameNameSetup(name: name)
    }
    
    func styleCell() {
        cellView.layer.cornerRadius = K.TableCells.borderRadius
        cellView.layer.borderWidth = K.TableCells.strokeWidth
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleCell()
    }

}
