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
    case GetSpecies(String, String)
    case GetPokemonInfo(String)
    case GetWebhook(String, Int, String)
    case GetMove(String)
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
        case .GetSpecies(let offset, let pageSize):
            let query = "pokemon-species?"
            let offset = "offset=" + offset
            let limit = "&limit=" + pageSize
            return "\(baseURL)" + query + offset + limit
        case .GetPokemonInfo(let dexId):
            let query = "pokemon/"
            return "\(baseURL)" + query + dexId
        case .GetMove(let url):
            return url
        case .GetWebhook:
            return WebhookPath
        }
    }

    public var method: String {
        switch self {
        case .GetPokedex:
            return "GET"
        case .GetSpecies:
            return "GET"
        case .GetPokemonInfo:
            return "GET"
        case .GetMove:
            return "GET"
        case .GetWebhook:
            return "POST"

        }
    }
    
    public var header: [String: String] {
        switch self {
        case .GetPokedex:
            return ["Content-Type": "application/json", "accept": "application/json"]
        case .GetSpecies:
            return ["Content-Type": "application/json", "accept": "application/json"]
        case .GetPokemonInfo:
            return ["Content-Type": "application/json", "accept": "application/json"]
        case .GetMove:
            return ["Content-Type": "application/json", "accept": "application/json"]
        case .GetWebhook:
            return ["AppID": Bundle.main.bundleIdentifier!]
        }
    }
    
    public var params: [String: AnyObject]? {
        switch self {
        case .GetPokedex:
            return nil
        case .GetSpecies:
            return nil
        case .GetPokemonInfo:
            return nil
        case .GetMove:
            return nil
        case .GetWebhook(let name, let id, let op):
            return ["name": name, "id": id, "op":op] as [String:AnyObject]
        }
    }
}
