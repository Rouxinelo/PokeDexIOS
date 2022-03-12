//
//  PokeRequest.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import Foundation

// MARK: - Delegate Protocol
protocol PokeRequestDelegate{
    func recievedPokeList(data: pokeData)
    func recievedPokeCount(count: Int)
    }

struct PokeRequest{
    
    // MARK: - Local Variables
    
    var delegate: PokeRequestDelegate?
    var requestURL: String = K.URLS.searchUrl
    let countURL: String = K.URLS.searchCount
    
    // MARK: - GET Request functions

    // gets pokemon URLS and count
    func fetchData(op: String){
        var urlToUse = ""
        if op == "LIST"{
            urlToUse = requestURL
        } else if op == "COUNT" {
            urlToUse = countURL
        }
        if let url = URL(string: urlToUse){
        let session = URLSession(configuration: .default)
        let sem = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let results = try decoder.decode(pokeData.self, from: safeData)
                        if op == "LIST"{
                            delegate?.recievedPokeList(data: results)
                        } else if op == "COUNT" {
                            delegate?.recievedPokeCount(count: results.count)
                        }
                    } catch{
                        print(error)
                    }
                    }
            }
            sem.signal()
            }
            task.resume()
            sem.wait()
        }
    }
}
