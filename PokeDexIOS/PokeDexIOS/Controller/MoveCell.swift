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
        moveNameLabel.text = move.move.name
        whenLearnedLabel.text = String(move.version_group_details.first!.level_learned_at)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
