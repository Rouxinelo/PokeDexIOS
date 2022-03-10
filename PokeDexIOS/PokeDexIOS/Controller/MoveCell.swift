//
//  TableViewCell.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 10/03/2022.
//

import UIKit

class MoveCell: UITableViewCell {

    @IBOutlet weak var moveNameLabel: UILabel!
    @IBOutlet weak var whenLearnedLabel: UILabel!
        
    func loadMove(move: possibleMove){
        moveNameLabel.text = move.move.name.capitalizingFirstLetter()
        if move.version_group_details.first!.level_learned_at == 0 {
            whenLearnedLabel.text = move.version_group_details.first?.move_learn_method.name.capitalizingFirstLetter()
        } else {
            whenLearnedLabel.text = "Lvl " +  String(move.version_group_details.first!.level_learned_at)
        }
    }
    
    func loadImage(){
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
