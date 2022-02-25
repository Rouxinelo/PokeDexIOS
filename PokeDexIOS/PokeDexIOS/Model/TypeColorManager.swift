//
//  TypeColorManager.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 25/02/2022.
//

import Foundation
import UIKit

struct TypeColorManager{
    
    var cons = 255.0
    var type: String?
    func getColorForType() -> UIColor{
        print(type!)
        switch type{
        case "bug":
            return UIColor(displayP3Red: 221.0/cons, green: 255.0/cons, blue: 0, alpha: 1)
        case "electric":
            return UIColor(displayP3Red: 255.0/cons, green: 247.0/cons, blue: 0, alpha: 1)
        case "fire":
            return UIColor(displayP3Red: 255.0/cons, green: 0, blue: 0, alpha: 1)
        case "grass":
            return UIColor(displayP3Red: 16.0/cons, green: 138.0/cons, blue: 0, alpha: 1)
        case "normal":
            return UIColor(displayP3Red: 120.0/cons, green: 120.0/cons, blue: 120.0/cons, alpha: 1)
        case "rock":
            return UIColor(displayP3Red: 117.0/cons, green: 90.0/cons, blue: 61.0/cons, alpha: 1)
        case "dark":
            return UIColor(displayP3Red: 46.0/cons, green: 41.0/cons, blue: 35.0/cons, alpha: 1)
        case "fairy":
            return UIColor(displayP3Red: 252.0/cons, green: 146.0/cons, blue: 245.0/cons, alpha: 1)
        case "flying":
            return UIColor(displayP3Red: 146.0/cons, green: 198.0/cons, blue: 252.0/cons, alpha: 1)
        case "ground":
            return UIColor(displayP3Red: 130.0/cons, green: 104.0/cons, blue: 75.0/cons, alpha: 1)
        case "poison":
            return UIColor(displayP3Red: 93.0/cons, green: 15.0/cons, blue: 171.0/cons, alpha: 1)
        case "steel":
            return UIColor(displayP3Red: 90.0/cons, green: 90.0/cons, blue: 90.0/cons, alpha: 1)
        case "dragon":
            return UIColor(displayP3Red: 96.0/cons, green: 67.0/cons, blue: 224.0/cons, alpha: 1)
        case "fighting":
            return UIColor(displayP3Red: 105.0/cons, green: 47.0/cons, blue: 17.0/cons, alpha: 1)
        case "ghost":
            return UIColor(displayP3Red: 74.0/cons, green: 57.0/cons, blue: 150.0/cons, alpha: 1)
        case "ice":
            return UIColor(displayP3Red: 79.0/cons, green: 220.0/cons, blue: 255.0/cons, alpha: 1)
        case "psychic":
            return UIColor(displayP3Red: 255.0/cons, green: 66.0/cons, blue: 242.0/cons, alpha: 1)
        case "water":
            return UIColor(displayP3Red: 0, green: 145.0/cons, blue: 255.0/cons, alpha: 1)
        default:
            return .black
        }
    }
}
