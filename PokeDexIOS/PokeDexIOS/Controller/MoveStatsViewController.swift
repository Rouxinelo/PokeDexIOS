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
    @IBOutlet weak var moveNameLabel: UILabel!
    @IBOutlet weak var moveDescriptionLabel: UILabel!
    
    // MARK: - Local Variables
    
    var chosenMove: String?
    var moveName: String?

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
    
    // MARK: - Other functions
    
    func searchForEnglishDescription(entries: [flavor_text_entries]) -> String {
        for entry in entries {
            if entry.language.name == "en" {
                return entry.flavor_text
            }
        }
        return "No description available"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moveRequest.delegate = self
        learnersTableView.dataSource = self
        
        //moveNameLabel.text = moveName
        
        defineSwipeGesture()
    
        if let chosenMove = chosenMove {
            moveRequest.requestURL = chosenMove
            moveRequest.fetchData()
        }
        
        moveNameLabel.text = moveName
        moveDescriptionLabel.text = searchForEnglishDescription(entries: moveInfo!.flavor_text_entries)
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
            cell.learnerNameLabel.text = move.learned_by_pokemon[indexPath.row].name.capitalizingFirstLetter()
        }
        cell.layer.masksToBounds = true
        return cell
    }
}
