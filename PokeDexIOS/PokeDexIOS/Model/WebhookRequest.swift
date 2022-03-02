//
//  WebhookRequest.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 02/03/2022.
//

import Foundation

struct WebhookRequest: Codable{
    let name: String
    let id: Int
    let deviceID: Int
}
