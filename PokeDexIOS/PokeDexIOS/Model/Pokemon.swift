//
//  Pokemon.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import Foundation

struct pokemon: Codable{
    
    let id: Int
    let types: [atype]
    let height: Int
    let weight: Int
    let name: String
    let sprites: sprite
    let base_experience: Int
    let stats: [possibleStat]
}

struct atype: Codable{
    let slot: Int
    let type: type
}
//
struct type: Codable{
    let name: String
}

struct sprite: Codable{
    let front_default: String
    let front_shiny: String
}

struct possibleStat: Codable{
    let base_stat: Int
    let stat: stat
}

struct stat: Codable{
    let name: String
}
