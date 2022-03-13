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
    let type: Types
    let flavor_text_entries: [FlavorTextEntries]
    let learned_by_pokemon: [Learner]
}

struct Types: Codable {
    let name: String
}

struct FlavorTextEntries: Codable {
    let flavor_text: String
    let language: Language
}

struct Language: Codable {
    let name: String
}

struct Learner: Codable {
    let name: String
}


