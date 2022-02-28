//
//  Constants.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 26/02/2022.
//

import Foundation
import UIKit

struct K {
    
    struct Segues{
        static let pokeDexToAboutMe: String = "toAboutMe"
        static let pokeDexToPokeStats: String = "toPokeStats"
        static let pokeStatsToAboutMe: String = "toAboutMe"
        static let pokeStatsToAbilities: String = "toAbilities"
        static let pokeStatstoMoves: String = "toMoves"
    }
    
    struct TableCells{
        static let pokeDexCellNibName: String = "PokemonCell"
        static let pokeDexCellIdentifier: String = "ReusableCell"
        static let pokemonPerPage: Int = 7
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
