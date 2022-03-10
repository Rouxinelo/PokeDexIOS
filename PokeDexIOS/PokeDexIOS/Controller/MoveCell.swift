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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
