//
//  GamesViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 25/03/2022.
//

import UIKit

class GamesViewController: UIViewController {

    // MARK: - Button Onclick Actions
    
    @IBAction func homeButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        returnToPreviousScreen()
    }
    
    // MARK: - Navigation functions
    
    func returnToPreviousScreen(){
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Gesture Handlers
    
    func defineSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            returnToPreviousScreen()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defineSwipeGesture()
        
    }
    

    
}
