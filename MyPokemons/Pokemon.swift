//
//  Pokemon.swift
//  MyPokemons
//
//  Created by Lucheo Antonio Tombini Filho on 18/01/17.
//  Copyright © 2017 Lucheo Antonio Tombini Filho. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokeId: Int!
    
    
    var name: String {
        return _name
    }
    
    var pokeId: Int {
        return _pokeId
    }
    
    init(name: String, pokeId: Int) {
        self._name = name
        self._pokeId = pokeId
        
    }
}
