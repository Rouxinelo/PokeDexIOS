//
//  Pokemon.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import Foundation

struct Pokemon: Codable {
    
    let id: Int
    let types: [Atype]
    let height: Int
    let weight: Int
    var name: String
    let sprites: Sprite
    let base_experience: Int
    let stats: [PossibleStat]
    var moves: [PossibleMove]
}

struct Atype: Codable {
    let slot: Int
    let type: Type
}
//
struct Type: Codable {
    let name: String
}

struct Sprite: Codable {
    let front_default: String?
    let front_shiny: String?
}

struct PossibleStat: Codable {
    let base_stat: Int
    let stat: Stat
}

struct Stat: Codable {
    let name: String
}

struct PossibleMove: Codable {
    let move: Move
    let version_group_details: [Details]
}

struct Move: Codable {
    let name: String
    let url: String
}

struct Details: Codable {
    let level_learned_at: Int
    let move_learn_method: MoveLearnMethod
}

struct MoveLearnMethod: Codable {
    let name: String
}
