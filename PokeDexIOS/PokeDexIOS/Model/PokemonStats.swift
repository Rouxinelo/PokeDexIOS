//
//  PokemonStats.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import Foundation

// MARK: - Delegate Protocol
protocol PokemonStatsDelegate{
    func recievedPokeInfo(data: pokemon, single: Bool)
    func pokemonNotFound()
}

struct PokemonStats{
    
    // MARK: - Local Variables
    
    var delegate: PokemonStatsDelegate?
    var requestURL: String = "https://pokeapi.co/api/v2/pokemon/1/"
    let requestURLSingle: String = "https://pokeapi.co/api/v2/pokemon/"
    
    // MARK: - GET Request functions
    
    func fetchData(){
        if let url = URL(string: requestURL){
        let session = URLSession(configuration: .default)
        let sem = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let results = try decoder.decode(pokemon.self, from: safeData)
                        delegate?.recievedPokeInfo(data: results, single: false)
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
    
    // Requests made from searchbar
    func fetchPokemonSearch(urlString: String){
        if let url = URL(string: urlString){
        let session = URLSession(configuration: .default)
        let sem = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let results = try decoder.decode(pokemon.self, from: safeData)
                        delegate?.recievedPokeInfo(data: results, single: true)
                    } catch{
                        print(error)
                        delegate?.pokemonNotFound()
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
