//
//  WebHookRequest.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 02/03/2022.
//

import Foundation

struct WebhookRequest{
    
    let webhookURL: String = K.webhookURL
    let webhookData: WebhookData?
    
    func sendData(){
        guard let url = URL(string: webhookURL) else { return }
        let encoder = JSONEncoder()
        
        var request = URLRequest(url: url)

        do{
            let messageJSON = try encoder.encode(webhookData)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "content-type")
            request.httpBody = messageJSON
            let task = URLSession.shared.dataTask(with: request)
            task.resume()
        }catch{
            print("error")
        }
    }
}
