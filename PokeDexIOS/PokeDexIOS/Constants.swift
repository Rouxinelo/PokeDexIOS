//
//  Constants.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 26/02/2022.
//

import Foundation
import UIKit

struct K {
    
    static let webhookURL: String = "https://webhook.site/1f06d0d2-e48f-4135-90e3-e78a8e5b894f"
    static let pokemonPerPage: Int = 1
    static let baseSinglePokemonURL: String = "https://pokeapi.co/api/v2/pokemon/"
    static let sliderImage = "pokeballSlider"
    
    struct audioPlayer{
        static let favouriteSoundExtension: String = "mp3"
        static let favouriteSoundName: String = "caughtSound"
    }
    
    struct Segues{
        static let pokeDexToAboutMe: String = "toAboutMe"
        static let pokeDexToPokeStats: String = "toPokeStats"
        static let pokeStatsToAboutMe: String = "toAboutMe"
        static let pokeStatsToAbilities: String = "toAbilities"
        static let pokeStatstoMoves: String = "toMoves"
    }
    
    struct StatsScreen{
        static let borderRadius: CGFloat = 15.0
        static let strokeWidth: CGFloat = 1.0
        static let spriteRadius: CGFloat = 50
        static let spriteStrokeWidth: CGFloat = 3.0
    }
    
    struct TableCells{
        static let pokeDexCellNibName: String = "PokemonCell"
        static let pokeDexCellIdentifier: String = "ReusableCell"
        static let borderRadius: CGFloat = 15.0
        static let strokeWidth: CGFloat = 1.0
    }
    
    struct SearchBar{
        static let initialPlaceHolder: String = "Search: Pokemon Name/ID"
        static let errorPlaceHolder: String = "Error, Pokemon not found"
    }
    
    struct URLS{
        static let searchUrl: String = "https://pokeapi.co/api/v2/pokemon?limit="
        static let searchOffSet: String = "&offset=0"
        static let searchCount: String = "https://pokeapi.co/api/v2/pokemon?limit=1&offset=0"
    }
    
    struct BarButton{
        static let notFav = UIImage(systemName:  "heart")
        static let fav = UIImage(systemName:  "heart.fill")
    }
}
