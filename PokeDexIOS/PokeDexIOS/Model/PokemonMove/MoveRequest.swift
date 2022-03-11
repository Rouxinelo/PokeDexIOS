//
//  MoveRequest.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 11/03/2022.
//

import Foundation

// MARK: - Delegate Protocol
protocol MoveRequestDelegate{
    func recievedMoveInfo(data: PokemonMove)
}

struct MoveRequest{
    
    // MARK: - Local Variables
    
    var delegate: MoveRequestDelegate?

    var requestURL: String = "https://pokeapi.co/api/v2/move/1/"
    
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
                        let results = try decoder.decode(PokemonMove.self, from: safeData)
                        delegate?.recievedMoveInfo(data: results)
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
