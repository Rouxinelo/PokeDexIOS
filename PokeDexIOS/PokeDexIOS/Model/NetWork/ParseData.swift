//
//  ParseData.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 16/03/2022.
//

import Foundation

struct ParseData {

    let decoder = JSONDecoder()
    
    func parsePokeData(Data: Data) -> PokeData? {
        
        do {
            let data = try decoder.decode(PokeData.self, from: Data)
            return data
        } catch {
            print(error)
        }
        return nil
    }
    
    func parsePokemon(Data: Data) -> Pokemon? {
        do {
            let data = try decoder.decode(Pokemon.self, from: Data)
            return data
        } catch {
            print(error)
        }
        return nil
    }
    
    func parsePokemonMove(Data: Data) -> PokemonMove? {
        
        do {
            let data = try decoder.decode(PokemonMove.self, from: Data)
            return data
        } catch {
            print(error)
        }
        return nil
    }

}
