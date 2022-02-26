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
    }
    
    struct TableCells{
        static let pokeDexCellNibName: String = "PokemonCell"
        static let pokeDexCellIdentifier: String = "ReusableCell"
    }
    
    struct SearchBar{
        static let initialPlaceHolder: String = "Search: Pokemon Name/ID"
        static let errorPlaceHolder: String = "Error, Pokemon not found"
    }
    
    struct URLS{
        static let pokemonCountLink: String = "https://pokeapi.co/api/v2/pokemon-species/?limit=0"
        static let firstPageUrl: String = "https://pokeapi.co/api/v2/pokemon?limit=7&offset=0"
        static let lastPageUrl: String = "https://pokeapi.co/api/v2/pokemon?limit=7&offset=896"
    }
    
    struct BarButton{
        static let notFav = UIImage(systemName:  "heart")
        static let fav = UIImage(systemName:  "heart.fill")
        
    }
}
