//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Philippe Santos on 16/01/23.
//

import Foundation

class PokemonRepository {
    func fetch(limit: Int, offset: Int) async -> [PokemonModel]{
        let urlOp = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)")
        guard let url = urlOp else { fatalError() }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for:request)
            
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            let decoder = JSONDecoder()
            
            let res = try decoder.decode(PokemonResponse.self, from: data)
            
            let pokemons = res.results.map{PokemonModel($0.name, $0.url)}
            
            return pokemons
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}

struct PokemonResponse: Codable {
    let count: Int
    let results: [PokemonResponseResultItem]
}

struct PokemonResponseResultItem: Codable {
    let name: String
    let url : String
}
