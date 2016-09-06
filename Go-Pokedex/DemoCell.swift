//
//  DemoCell.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 17/08/2016.
//  Copyright © 2016 Anna. All rights reserved.
//

import UIKit

class DemoCell: FoldingCell {
    
    var pokemonId: Int!
    
    @IBOutlet weak var _imgBack: UIView!
    @IBOutlet weak var _img: UIImageView!
   // @IBOutlet weak var _idLabel: UILabel!
    
    @IBOutlet weak var _nameLabel: UILabel!
    @IBOutlet weak var _barView: UIView!
    @IBOutlet weak var _idLabel2: UILabel!
    @IBOutlet weak var _description: UITextView!
    @IBOutlet weak var _backgroundHeader: UIImageView!
    
    @IBOutlet weak var _img2: UIImageView!
    @IBOutlet weak var _weightLabel: UILabel!
    
    @IBOutlet weak var _heightLabel: UILabel!
    @IBOutlet weak var _nameLabel2: UILabel!
    
    @IBOutlet weak var typeCase1View: UIView!
    @IBOutlet weak var _typeCase1Label: UILabel!
    @IBOutlet weak var typeCase2View: UIView!
    @IBOutlet weak var _typeCase21View: UIView!
    @IBOutlet weak var _typeCase21Label: UILabel!
    @IBOutlet weak var _typeCase22View: UIView!
    @IBOutlet weak var _typeCase22Label: UILabel!
    
    @IBOutlet weak var _spawnRateLabel: UILabel!
    @IBOutlet weak var _captureRateLabel: UILabel!
    
    @IBOutlet weak var _pokeEvo1: UIImageView!
    @IBOutlet weak var _pokeEvo2: UIImageView!
    @IBOutlet weak var _pokeEvo4: UIImageView!
    @IBOutlet weak var _pokeEvo5: UIImageView!
    @IBOutlet weak var _arrowEvo1: UIImageView!

    @IBOutlet weak var noEvolutionLabel: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    
    
    private var _name: String!
    
    var number: Int = 0 {
        didSet {
        }
        
    }
    
    var vc = MainTableViewController()
    
    func initHeader(pokemon: Pokemon) {
        self._img.image = pokemon.img
        self._img2.image = pokemon.img
        //self._idLabel.text = "#\(pokemon.id)"
        //self._idLabel2.text = "#\(pokemon.id)"
        self._nameLabel.text = pokemon.name.capitalizedString
        self._nameLabel2.text = pokemon.name.capitalizedString
        self._description.text = pokemon.description
        self._description.textColor = UIColor.whiteColor()
        self._description.font = UIFont (name: "OpenSans-Semibold", size: 16)!
        self._description.textAlignment = .Center
        self._imgBack.backgroundColor = pokemon.types[0].color
        self._barView.backgroundColor = pokemon.types[0].color
        self._heightLabel.text = pokemon.height
        self._weightLabel.text = pokemon.weight
        self._backgroundHeader.image = UIImage(named: "\(pokemon.types[0].name).jpg")
        self.noEvolutionLabel.hidden = true
    }
    
    func initMidCell(pokemon: Pokemon) {
        if pokemon.types[1].name == "" {
            self.typeCase1View.hidden = false
            self.typeCase2View.hidden = true
            self._typeCase1Label.text = pokemon.types[0].name.capitalizedString
            self.typeCase1View.backgroundColor = pokemon.types[0].color
        } else if pokemon.types[1].name != "" {
            self.typeCase1View.hidden = true
            self.typeCase2View.hidden = false
            self._typeCase21Label.text = pokemon.types[0].name.capitalizedString
            self._typeCase22Label.text = pokemon.types[1].name.capitalizedString
            self._typeCase21View.backgroundColor = pokemon.types[0].color
            self._typeCase22View.backgroundColor = pokemon.types[1].color
        }
        self._spawnRateLabel.text = pokemon.baseFlee
        self._captureRateLabel.text = pokemon.baseCatch
    }
    
    func initEvolution(pokemon: Pokemon) {
        if pokemon.evoIDs.count == 1 {
            self._pokeEvo1.unHide()
            self._pokeEvo2.unHide()
            self._arrowEvo1.unHide()
            self._pokeEvo4.hide()
            self._pokeEvo5.hide()
            self._pokeEvo1.image = pokemon.img
            self._pokeEvo2.image = UIImage(named: "\(pokemon.evoIDs[0]).png")
        } else if pokemon.evoIDs.count == 3 {
            self._pokeEvo1.unHide()
            self._pokeEvo2.unHide()
            self._pokeEvo4.unHide()
            self._pokeEvo5.unHide()
            self._arrowEvo1.unHide()
            self._pokeEvo1.image = pokemon.img
            self._pokeEvo2.image = UIImage(named: "\(pokemon.evoIDs[0]).png")
            self._pokeEvo4.image = UIImage(named: "\(pokemon.evoIDs[1]).png")
            self._pokeEvo5.image = UIImage(named: "\(pokemon.evoIDs[2]).png")
        } else {
            self._pokeEvo1.hide()
            self._pokeEvo2.hide()
            self._pokeEvo4.hide()
            self._pokeEvo5.hide()
            self._arrowEvo1.hide()
            self.noEvolutionLabel.hidden = false
        }
    }
    
    
    @IBAction func moreButtonPressed(sender: AnyObject) {
        self.vc.selectedPokemon = self.pokemonId
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func awakeFromNib() {
        
        foregroundView.layer.cornerRadius = 0
        foregroundView.layer.masksToBounds = true
        
        super.awakeFromNib()
    }
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}
