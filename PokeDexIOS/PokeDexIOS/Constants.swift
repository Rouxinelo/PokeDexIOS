//
//  Constants.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 26/02/2022.
//

import Foundation
import UIKit

struct K {
    
    static let pokemonPerPage: Int = 1
    
    static let sliderImage = "pokeballSlider"
    
    struct audioPlayer{
        static let favouriteSoundExtension: String = "mp3"
        static let favouriteSoundName: String = "caughtSound"
    }
    
    struct Segues{
        static let pokeDexToAboutMe: String = "toAboutMe"
        static let pokeDexToPokeStats: String = "toPokeStats"
        static let pokeStatsToAboutMe: String = "toAboutMe"
        static let pokeStatsToMovesAndAbilities: String = "toMovesAndAbilities"
        static let movesAndAbilitiesToMoveStats: String = "pokeMovesToMoveStats"
    }
    
    struct StatsScreen{
        static let borderRadius: CGFloat = 15.0
        static let strokeWidth: CGFloat = 1.0
        static let spriteRadius: CGFloat = 50
        static let spriteStrokeWidth: CGFloat = 3.0
    }
    
    struct TableCells{
        static let pokeDexCellIdentifier: String = "ReusableCell"
        static let borderRadius: CGFloat = 15.0
        static let strokeWidth: CGFloat = 1.0
        static let moveCellIdentifier: String = "MoveCell"
        static let learnerCellIdentifier: String = "LearnerCell"
    }
    
    struct SearchBar{
        static let initialPlaceHolder: String = "Search: Pokemon Name/ID"
        static let errorPlaceHolder: String = "Error, Pokemon not found"
    }
    
    struct BarButton{
        static let notFav = UIImage(systemName:  "heart")
        static let fav = UIImage(systemName:  "heart.fill")
    }
}
