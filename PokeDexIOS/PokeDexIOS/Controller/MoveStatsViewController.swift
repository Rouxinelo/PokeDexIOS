//
//  MoveStatsViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 11/03/2022.
//

import UIKit

class MoveStatsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var learnersTableView: UITableView!
    
    // MARK: - Local Variables
    
    var chosenMove: String?
    
    var moveRequest = MoveRequest()
    
    var moveInfo: PokemonMove?
    
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

        moveRequest.delegate = self
        learnersTableView.dataSource = self
        
        defineSwipeGesture()
        
        if let chosenMove = chosenMove {
            moveRequest.requestURL = chosenMove
            moveRequest.fetchData()
        }
    }
}

extension MoveStatsViewController: MoveRequestDelegate {
    func recievedMoveInfo(data: PokemonMove) {
        moveInfo = data
    }
}

extension MoveStatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let move = moveInfo {
            return move.learned_by_pokemon.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "learnerCell", for: indexPath) as! LearnerCell
        if let move = moveInfo{
            cell.learnerNameLabel.text = move.learned_by_pokemon[indexPath.row].name
        }
        cell.layer.masksToBounds = true
        return cell
    }
}
