//
//  ApiPath.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 13/03/2022.
//

import Foundation

let URLPath = "https://pokeapi.co/api/v2/"
let WebhookPath = "https://webhook.site/1f06d0d2-e48f-4135-90e3-e78a8e5b894f"

protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
}

enum API {
    case GetPokedex(String, String)
    case GetPokemonInfo(String)
    case GetWebhook
}

extension API: TargetType {

    public var baseURL: String {
        return URLPath
    }

    public var path: String {
        switch self {
        case .GetPokedex(let offset, let pageSize):
            let query = "pokemon?"
            let offset = "offset=" + offset
            let limit = "&limit=" + pageSize
            return "\(baseURL)" + query + offset + limit
        case .GetPokemonInfo(let dexId):
            let query = "pokemon/"
            return "\(baseURL)" + query + dexId
        case .GetWebhook:
            return WebhookPath
        }
    }

    public var method: String {
        switch self {
        case .GetPokedex:
            return "GET"
        case .GetPokemonInfo:
            return "GET"
        case .GetWebhook:
            return "POST"
        }
    }
}
