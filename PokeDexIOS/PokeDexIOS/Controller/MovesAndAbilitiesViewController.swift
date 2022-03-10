//
//  MovesAndAbilitiesViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 10/03/2022.
//

import UIKit

class MovesAndAbilitiesViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var ability1Label: UILabel!
    @IBOutlet weak var ability2Label: UILabel!
    @IBOutlet weak var moveTableCell: UITableView!
    
    // MARK: - Local Variables
    
    var chosenPokemon: pokemon?

    var moveArray =  [possibleMove]()
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
        
        moveTableCell.dataSource = self
        
        defineSwipeGesture()
    }
    
}

// MARK: - Table View Data Source

extension MovesAndAbilitiesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moveArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableCells.moveCellIdentifier, for: indexPath) as! MoveCell
        
        cell.loadMove(move: moveArray[indexPath.row])
        
        return cell
    }
}
