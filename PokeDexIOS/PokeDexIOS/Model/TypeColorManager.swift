//
//  TypeColorManager.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 25/02/2022.
//

import Foundation
import UIKit

struct TypeColorManager{
    
    var type: String?
    
    func getColorForType() -> UIColor{
        switch type{
        case "bug":
            return UIColor(displayP3Red: 221, green: 255, blue: 0, alpha: 1)
        case "electric":
            return UIColor(displayP3Red: 255, green: 247, blue: 0, alpha: 1)
        case "fire":
            return UIColor(displayP3Red: 255, green: 0, blue: 0, alpha: 1)
        case "grass":
            return UIColor(displayP3Red: 16, green: 138, blue: 0, alpha: 1)
        case "normal":
            return UIColor(displayP3Red: 120, green: 120, blue: 120, alpha: 1)
        case "rock":
            return UIColor(displayP3Red: 117, green: 90, blue: 61, alpha: 1)
        case "dark":
            return UIColor(displayP3Red: 46, green: 41, blue: 35, alpha: 1)
        case "fairy":
            return UIColor(displayP3Red: 252, green: 146, blue: 245, alpha: 1)
        case "flying":
            return UIColor(displayP3Red: 146, green: 198, blue: 252, alpha: 1)
        case "ground":
            return UIColor(displayP3Red: 130, green: 104, blue: 75, alpha: 1)
        case "poison":
            return UIColor(displayP3Red: 93, green: 15, blue: 171, alpha: 1)
        case "steel":
            return UIColor(displayP3Red: 90, green: 90, blue: 90, alpha: 1)
        case "dragon":
            return UIColor(displayP3Red: 96, green: 67, blue: 224, alpha: 1)
        case "fighting":
            return UIColor(displayP3Red: 105, green: 47, blue: 17, alpha: 1)
        case "ghost":
            return UIColor(displayP3Red: 74, green: 57, blue: 150, alpha: 1)
        case "ice":
            return UIColor(displayP3Red: 79, green: 220, blue: 255, alpha: 1)
        case "psychic":
            return UIColor(displayP3Red: 255, green: 66, blue: 242, alpha: 1)
        case "water":
            return UIColor(displayP3Red: 0, green: 145, blue: 255, alpha: 1)
        default:
            return .black
        }
    }
}
