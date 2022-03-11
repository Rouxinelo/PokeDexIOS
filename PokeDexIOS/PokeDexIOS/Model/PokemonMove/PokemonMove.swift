//
//  PokemonMove.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 11/03/2022.
//

import Foundation

struct PokemonMove: Codable {
    let accuracy: Int?
    let power: Int?
    let pp: Int?
    let type: types
    let flavor_text_entries: [flavor_text_entries]
    let learned_by_pokemon: [learner]
}

struct types: Codable {
    let name: String
}

struct flavor_text_entries: Codable{
    let flavor_text: String
    let language: language
}

struct language: Codable{
    let name: String
}

struct learner: Codable{
    let name: String
}


