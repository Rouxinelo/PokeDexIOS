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
        checkButton()
    }

}

// MARK - Pagination

extension ViewController{
    
    func checkButton(){
        if pageLabel.text == "1" {
            prevPageButton.isHidden = true
        } else if pageLabel.text == "10"{
            nextPageButton.isHidden = true
        } else {
            prevPageButton.isHidden = false
            nextPageButton.isHidden = false
        }
    }
    
    @IBAction func pageButtonPressed(_ sender: UIButton) {
        if sender == prevPageButton{
            pageLabel.text = String(Int(pageLabel.text!)! - 1)
            checkButton()
        } else if sender == nextPageButton {
            pageLabel.text = String(Int(pageLabel.text!)! + 1)
            checkButton()
        }
    }
}

