//
//  PokeRequest.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import Foundation

protocol PokeRequestDelegate{
    func recievedPokeList(data: pokeData)
    
    func recievedPokeCount(count: Int)
}

struct PokeRequest{
    
    var delegate: PokeRequestDelegate?
    
    var previousURL: String?
    
    var pokemonCountLink: String = "https://pokeapi.co/api/v2/pokemon-species/?limit=0"
    
    var requestURL: String? = "https://pokeapi.co/api/v2/pokemon?limit=7&offset=0"
    
    let firstPageURL: String = "https://pokeapi.co/api/v2/pokemon?limit=7&offset=0"
    
    let lastPageURL: String = "https://pokeapi.co/api/v2/pokemon?limit=7&offset=896"
    
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
    
    func fetchPokeNumber(){
        if let url = URL(string: pokemonCountLink){
        let session = URLSession(configuration: .default)
        let sem = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let results = try decoder.decode(pokeData.self, from: safeData)
                        delegate?.recievedPokeCount(count: results.count)
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
