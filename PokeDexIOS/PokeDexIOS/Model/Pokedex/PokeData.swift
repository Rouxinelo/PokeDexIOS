//
//  PokeData.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import Foundation

struct pokeData: Codable{
    let count: Int
    let next: String?
    let previous: String?
    let results: [result]
}

struct result: Codable{
    let url: String
}
