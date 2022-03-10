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
    var name: String
    let sprites: sprite
    let base_experience: Int
    let stats: [possibleStat]
    let moves: [possibleMove]
    let abilities: [possibleAbility]
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
    let front_shiny: String?
}

struct possibleStat: Codable{
    let base_stat: Int
    let stat: stat
}

struct stat: Codable{
    let name: String
}

struct possibleMove: Codable{
    let move: move
    let version_group_details: [details]
}

struct move: Codable{
    let name: String
    let url: String
}

struct details: Codable{
    let level_learned_at: Int
    let move_learn_method: move_learn_method
}

struct move_learn_method: Codable{
    let name: String
}

struct possibleAbility: Codable{
    let ability: ability
    let is_hidden: Bool
}

struct ability: Codable{
    let name: String
}
