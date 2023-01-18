//
//  PokedexSearchController.swift
//  Pokedex
//
//  Created by Philippe Santos on 16/01/23.
//

import Foundation


class PokedexSearchController {
    let repository = PokemonRepository()
    var allPokemons: [PokemonModel] = []
    var pokemons: [PokemonModel] = []
    var updateUI: (() -> Void)?
  
    func fetchAllPokemons() {
        Task {
            allPokemons = await repository.fetch(limit: 100, offset: 0)
            pokemons = allPokemons
            DispatchQueue.main.async {
                self.updateUI?()
            }
         }
    }
    
    func filterPokemonByText(text: String) {
        if text.isEmpty {
            pokemons = allPokemons
        } else {
            pokemons = allPokemons.filter({ p in p.name.lowercased().contains(text.lowercased())})
        }
        self.updateUI?()
    }
}
