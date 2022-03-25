//
//  TableViewCell.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 10/03/2022.
//

import UIKit

class MoveCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var moveNameLabel: UILabel!
    @IBOutlet weak var whenLearnedLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    // MARK: - Other functions
    
    func getMethod(text: String) -> String {
        switch text{
        case "machine":
            return "Hm/Tm"
        default:
            return text.capitalizingFirstLetter()
        }
    }
    
    func getLvl(lvl: Int) -> String {
        switch lvl{
            case 1...9:
                return "Lvl 0" + String(lvl)
            default:
                return "Lvl " + String(lvl)
        }
    }
    
    func loadMove(move: PossibleMove) {
        moveNameLabel.text = move.move.name.capitalizingFirstLetter()
        if move.version_group_details.first!.level_learned_at == 0 {
            whenLearnedLabel.text = getMethod(text: (move.version_group_details.first?.move_learn_method.name)!)
        } else {
            whenLearnedLabel.text =   getLvl(lvl: move.version_group_details.first!.level_learned_at)
        }
    }
    
    func styleCell() {
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
