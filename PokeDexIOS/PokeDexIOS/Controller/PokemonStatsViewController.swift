//
//  PokemonStatsViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 25/02/2022.
//

import UIKit

class PokemonStatsViewController: UIViewController {

    // Bar Button OnClickAction
    @IBAction func InformationClicked(_ sender: Any) {
        performSegue(withIdentifier: K.Segues.pokeStatsToAboutMe, sender: sender)
    }
    
    @IBAction func favButtonClicked(_ sender: UIBarButtonItem) {
        switch sender.image{
        case K.BarButton.notFav:
            sender.image = K.BarButton.fav
        case K.BarButton.fav:
            sender.image = K.BarButton.notFav
        default:
            print("NO IMAGE")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
