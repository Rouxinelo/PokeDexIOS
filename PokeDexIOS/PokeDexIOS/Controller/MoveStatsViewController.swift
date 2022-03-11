//
//  MoveStatsViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 11/03/2022.
//

import UIKit

class MoveStatsViewController: UIViewController {

    // MARK: - Local Variables
    
    var chosenMove: String?
    
    // MARK: - Button Onclick Actions
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        returnToPreviousScreen()
    }
    
    // MARK: - Navigation functions
    
    func returnToPreviousScreen(){
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Gesture Handlers
    
    func defineSwipeGesture(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer){
        if gesture.direction == .right {
            returnToPreviousScreen()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defineSwipeGesture()

        if let chosenMove = chosenMove {
            print(chosenMove)
        }
    }

}
