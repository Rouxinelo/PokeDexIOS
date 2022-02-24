//
//  PokemonStats.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import Foundation

protocol PokemonStatsDelegate{
    func recievedPokeInfo(data: pokemon)
}

struct PokemonStats{
    
    var delegate: PokemonStatsDelegate?
    
    var requestURL: String = "https://pokeapi.co/api/v2/pokemon/1/"
    let resultString: String = ""
    
    func fecthData(){
        if let url = URL(string: requestURL){
        let session = URLSession(configuration: .default)
        let sem = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let results = try decoder.decode(pokemon.self, from: safeData)
                        delegate?.recievedPokeInfo(data: results)
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
