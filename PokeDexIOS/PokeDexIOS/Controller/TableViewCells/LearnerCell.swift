//
//  LearnerCell.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 11/03/2022.
//

import UIKit

class LearnerCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var learnerNameLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    // MARK: - Style the cell
    
    func styleCell() {
        cellView.layer.cornerRadius = K.TableCells.borderRadius
        cellView.layer.borderWidth = K.TableCells.strokeWidth
    }
    
    func loadCell(pokemonName: String) {
        learnerNameLabel.text = pokemonName.capitalizingFirstLetter()
    }
    
    // MARK: - awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleCell()
    }
    
}
