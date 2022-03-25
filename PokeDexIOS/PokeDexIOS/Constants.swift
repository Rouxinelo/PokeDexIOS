//
//  Constants.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 26/02/2022.
//

import Foundation
import UIKit

struct K {
    
    static let pokemonPerPage: Int = 2
    
    static let sliderImage = "pokeballSlider"
    
    struct audioPlayer{
        static let favouriteSoundExtension: String = "mp3"
        static let favouriteSoundName: String = "caughtSound"
        static let themeSongExtension: String = "mp3"
        static let themeSongName: String = "themeSong"
    }
    
    struct Segues{
        static let mainMenuToAboutMe: String = "toAboutMe"
        static let mainMenuToPokedex: String = "toPokeDex"
        static let mainMenuToPokemonStats: String = "randomSearch"
        static let pokeDexToPokeStats: String = "toPokeStats"
        static let pokeStatsToMovesAndAbilities: String = "toMovesAndAbilities"
        static let movesAndAbilitiesToMoveStats: String = "pokeMovesToMoveStats"
        static let movesAndAbilitiesToGames: String = "toGames"
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
