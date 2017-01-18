//
//  PokeCell.swift
//  MyPokemons
//
//  Created by Lucheo Antonio Tombini Filho on 18/01/17.
//  Copyright © 2017 Lucheo Antonio Tombini Filho. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalized
        pokemonImg.image = UIImage(named: "\(self.pokemon.pokeId)")
        
    }
    
}
