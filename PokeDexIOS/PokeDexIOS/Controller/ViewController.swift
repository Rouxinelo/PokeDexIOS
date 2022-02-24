//
//  ViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 24/02/2022.
//

import UIKit

class ViewController: UIViewController {

    // Button Outlets
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var prevPageButton: UIButton!
    
    // Text Label Outlets
    @IBOutlet weak var pageLabel: UILabel!
    
    // Table View Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Image View Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    
    var URLarray = [String]()
    
    var PokemonArray = [pokemon]()
    
    var searchForPokemonUrls = PokeRequest()
    var searchForPokemonStats = PokemonStats()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

