//
//  WebHookRequest.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 02/03/2022.
//

import Foundation

struct WebhookRequest {
    
    let webhookURL: String = API.GetWebhook.path
    var webhookData: WebhookData? = nil
    
    func sendData() {
        guard let url = URL(string: webhookURL)
        else {
            return
        }
        
        let encoder = JSONEncoder()
        
        var request = URLRequest(url: url)

        do {
            if let data = webhookData {
                let messageJSON = try encoder.encode(data)
                request.httpMethod = API.GetWebhook.method
                request.addValue("application/json", forHTTPHeaderField: Bundle.main.bundleIdentifier!)
                request.httpBody = messageJSON
                let task = URLSession.shared.dataTask(with: request)
                task.resume()
            }
        } catch {
            print("error")
        }
    }
}
