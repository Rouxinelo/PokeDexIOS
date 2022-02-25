//
//  PokeRequest.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import Foundation

protocol PokeRequestDelegate{
    func recievedPokeList(data: pokeData)
}

struct PokeRequest{
    
    var delegate: PokeRequestDelegate?
    
    var previousURL: String?
    
    var initialLink = "https://pokeapi.co/api/v2/pokemon?limit="
    var finalLink = "&offset="
    var requestURL: String? = "https://pokeapi.co/api/v2/pokemon?limit=6&offset=0"
    
    func fetchData(){
        if let url = URL(string: requestURL!){
        let session = URLSession(configuration: .default)
        let sem = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let results = try decoder.decode(pokeData.self, from: safeData)
                        delegate?.recievedPokeList(data: results)
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
    
    mutating func setURL(pokePerPage: Int, offset: Int){
        requestURL = initialLink + String(pokePerPage) + finalLink + String(offset)
    }
}
