//
//  PokemonDetailVC.swift
//  MyPokemons
//
//  Created by Lucheo Antonio Tombini Filho on 19/01/17.
//  Copyright © 2017 Lucheo Antonio Tombini Filho. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokeIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var nextEvoLbl: UILabel!
    @IBOutlet weak var evoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name.capitalized
        
        let img = UIImage(named: "\(pokemon.pokeId)")
        mainImg.image = img
        evoImg.image = img
        pokeIdLbl.text = "\(pokemon.pokeId)"
        
        
        pokemon.downloadPokemonDetail {
            self.updateUI()
        }

    }
    
    func updateUI() {
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        typeLbl.text = pokemon.type
        descLbl.text = pokemon.descrip
        
        if pokemon.nextEvoId == "" {
            nextEvoImg.isHidden = true
            nextEvoLbl.text = "No evolutions"
        } else {
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
            let str = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLevel)"
            nextEvoLbl.text = str
        }
        
        
        
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
