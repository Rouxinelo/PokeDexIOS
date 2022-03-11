//
//  MoveStatsViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 11/03/2022.
//

import UIKit

class MoveStatsViewController: UIViewController {

    var chosenMove: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let chosenMove = chosenMove {
            print(chosenMove)
        }
    }

}
