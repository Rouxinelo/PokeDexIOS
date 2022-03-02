//
//  WebHookRequest.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 02/03/2022.
//

import Foundation

struct WebhookRequest{
    
    let webhookURL: String = K.webhookURL
    var webhookData: WebhookData? = nil
    
    func sendData(){
        guard let url = URL(string: webhookURL)
        else {
            print("erro")
            return
            
        }
        let encoder = JSONEncoder()
        
        var request = URLRequest(url: url)

        do{
            if let data = webhookData{
                let messageJSON = try encoder.encode(data)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "content-type")
                print(String(data: messageJSON, encoding: .utf8))
                request.httpBody = messageJSON
                let task = URLSession.shared.dataTask(with: request)
                task.resume()
            }
        }catch{
            print("error")
        }
    }
}
