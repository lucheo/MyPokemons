//
//  Pokemon.swift
//  MyPokemons
//
//  Created by Lucheo Antonio Tombini Filho on 18/01/17.
//  Copyright © 2017 Lucheo Antonio Tombini Filho. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokeId: Int!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _defense: String!
    private var _attack: String!
    private var _nextEvoTxt: String!
    private var _pokemonURL: String!
    private var _descrip: String!
    private var _nextEvoName: String!
    private var _nextEvoId: String!
    private var _nextEvoLevel: String!
    
    var nextEvoName: String {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var descrip: String {
        if _descrip == nil {
            _descrip = ""
        }
        return _descrip
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoLevel: String {
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    
    
    var name: String {
        return _name
    }
    
    var pokeId: Int {
        return _pokeId
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var height: String {
        if _height == nil {
            _height = ""
            
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
            
        }
        return _defense
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
            
        }
        return _attack
    }
    var nextEvoTxt: String {
        if _nextEvoTxt == nil {
            _nextEvoTxt = ""
            
        }
        return _nextEvoTxt
    }
    
    init(name: String, pokeId: Int) {
        self._name = name
        self._pokeId = pokeId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokeId)"
        
    }
    
    func downloadPokemonDetail(completed: DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                    
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                    
                }
                
                if let type = dict["types"] as? [Dictionary<String, String>], type.count > 0 {
                    if let name = type[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if type.count > 1 {
                        for x in 1..<type.count {
                            
                            if let name = type[x]["name"] {
                                self._type = self._type + "/\(name.capitalized)"

                            }
                        }
                    }
                    
                    
                } else {
                    self._type = ""
                    
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] {
                    if let endURL = descArr[0]["resource_uri"] {
                        let url = "\(URL_BASE)\(endURL)"
                        Alamofire.request(url).responseJSON(completionHandler: { (response) in
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let descrip = descDict["description"] as? String {
                                    let newDescrip = descrip.replacingOccurrences(of: "POKMON", with: "POKEMON")
                                    self._descrip = newDescrip
                                }
                            }
                            
                        })
                    }
                } else {
                    self._descrip = ""
                }
                
                if let evolution = dict["evolutions"] as? [Dictionary<String, AnyObject>] {
                    if let nextEvo = evolution[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvoName = nextEvo
                            
                            if let uri = evolution[0]["resource_uri"] as? String {
                                let newUri = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let evoId = newUri.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvoId = evoId
                                
                            }
                            
                            if let lvlExist = evolution[0]["level"] {
                                if let lvl = lvlExist as? Int {
                                    self._nextEvoLevel = "\(lvl)"
                                    
                                }
                                
                            } else {
                                self._nextEvoLevel = ""
                            }
                            
                        }
                    }
                }
                
            }
            
            
            
        }
        completed()

        
    }
}
