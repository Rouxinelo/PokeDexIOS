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
    @IBOutlet weak var powerText: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var accuracyText: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var ppText: UILabel!
    @IBOutlet weak var ppLabel: UILabel!
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var footerView: UIView!
    
    // MARK: - Local Variables
    
    var chosenMove: String?
    var moveName: String?

    var moveInfo: PokemonMove?
    
    var moveRequest = MoveRequest()
    var colorPicker = TypeColorManager()
    
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
    
    // MARK: - Set page style
    
    func styleHeader(move: PokemonMove){
        
        colorPicker.type = move.type.name
        
        headerStackView.backgroundColor = colorPicker.getColorForType()
        headerStackView.layer.borderWidth = K.TableCells.strokeWidth
        headerStackView.layer.cornerRadius = K.TableCells.borderRadius
        
        powerLabel.text = String(move.power ?? 0)
        powerLabel.textColor = colorPicker.getTextFontColor()
        powerText.textColor = colorPicker.getTextFontColor()
        
        accuracyLabel.text = String(move.accuracy ?? 0)
        accuracyLabel.textColor = colorPicker.getTextFontColor()
        accuracyText.textColor = colorPicker.getTextFontColor()
        
        ppLabel.text = String(move.pp ?? 0)
        ppLabel.textColor = colorPicker.getTextFontColor()
        ppText.textColor = colorPicker.getTextFontColor()
        
        moveNameLabel.text = moveName?.capitalizingFirstLetter()
        moveNameLabel.textColor = colorPicker.getTextFontColor()
        
        moveDescriptionLabel.text = searchForEnglishDescription(entries: move.flavor_text_entries)
    }
    
    // MARK: - Other functions
    
    func searchForEnglishDescription(entries: [FlavorTextEntries]) -> String {
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
        
        defineSwipeGesture()
    
        if let chosenMove = chosenMove {
            moveRequest.requestURL = chosenMove
            moveRequest.fetchData()
        }
        
        if let move = moveInfo {
            styleHeader(move: move)
        }
    }
}

// MARK: - Move Request Delegate

extension MoveStatsViewController: MoveRequestDelegate {
    func recievedMoveInfo(data: PokemonMove) {
        moveInfo = data
    }
}

// MARK: - Table View Delegate

extension MoveStatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let move = moveInfo {
            return move.learned_by_pokemon.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableCells.learnerCellIdentifier, for: indexPath) as! LearnerCell
        if let move = moveInfo{
            cell.loadCell(pokemonName: move.learned_by_pokemon[indexPath.row].name)
        }
        return cell
    }
}
