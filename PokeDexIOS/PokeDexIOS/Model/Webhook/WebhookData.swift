//
//  WebhookRequest.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 02/03/2022.
//

import Foundation

struct WebhookData: Codable {
    var name: String
    var id: Int
    var op: String
    
    init(name: String, id: Int, op: String) {
        self.name = name
        self.id = id
        self.op = op
    }
}
