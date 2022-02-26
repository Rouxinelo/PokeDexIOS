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
    let abilities: [possibleAbility]
    let moves: [possibleMoves]
    let height: Int
    let weight: Int
    let name: String
    let sprites: sprite
    let base_experience: Int
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
    let back_default: String
    let front_default: String
}


struct possibleMoves: Codable{
    let move: move
}

struct move: Codable{
    let name: String
}

struct possibleAbility: Codable{
    let ability: ability
}

struct ability: Codable{
    let name: String
}
