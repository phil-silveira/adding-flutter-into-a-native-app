//
//  Pokemon.swift
//  Pokedex
//
//  Created by Philippe Santos on 16/01/23.
//

import Foundation

class PokemonModel {
    let id: String
    let name: String
    
    init(_ name: String, _ detailUrl: String) {
        self.name = name
        self.id = detailUrl.components(separatedBy: "/")[6]
    }
}
