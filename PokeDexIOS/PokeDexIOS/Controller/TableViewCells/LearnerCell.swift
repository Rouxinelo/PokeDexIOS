//
//  LearnerCell.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 11/03/2022.
//

import UIKit

class LearnerCell: UITableViewCell {

    @IBOutlet weak var learnerNameLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    func styleCell(){
        cellView.layer.cornerRadius = K.TableCells.borderRadius
        cellView.layer.borderWidth = K.TableCells.strokeWidth
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
