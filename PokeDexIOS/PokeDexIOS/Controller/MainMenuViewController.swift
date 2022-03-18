//
//  MainMenuViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 18/03/2022.
//

import UIKit

class MainMenuViewController: UIViewController {

    // MARK: - IBActions
    
    @IBAction func pokedexButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.mainMenuToPokedex, sender: self)
    }
    
    @IBAction func aboutButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.mainMenuToAboutMe, sender: self)
    }
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

// MARK: - Prepare for segue

extension MainMenuViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.mainMenuToPokedex {
            let VC = segue.destination as! PokedexViewController
        }
    }
}
