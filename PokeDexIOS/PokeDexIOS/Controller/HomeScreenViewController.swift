//
//  HomeScreenViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 25/02/2022.
//

import UIKit

class HomeScreenViewController: UIViewController {

    
    @IBAction func goToPokedex(_ sender: UIButton) {
        performSegue(withIdentifier: "toPokeDex", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
