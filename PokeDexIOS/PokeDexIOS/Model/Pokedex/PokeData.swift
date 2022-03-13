//
//  PokeData.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import Foundation

struct PokeData: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Result]
}

struct Result: Codable {
    let url: String
}
