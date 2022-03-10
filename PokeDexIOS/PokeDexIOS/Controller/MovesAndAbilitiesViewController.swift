//
//  MovesAndAbilitiesViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 10/03/2022.
//

import UIKit

class MovesAndAbilitiesViewController: UIViewController {

    @IBOutlet weak var ability1Label: UILabel!
    @IBOutlet weak var ability2Label: UILabel!
    
    @IBOutlet weak var moveTableCell: UITableView!
    
    func returnToPreviousScreen(){
        navigationController?.popViewController(animated: true)
    }
    
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
    
    let test: [String] = ["Abc", "Bcd", "Def"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moveTableCell.dataSource = self
        
        defineSwipeGesture()
    }
    
}

extension MovesAndAbilitiesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableCells.moveCellIdentifier, for: indexPath)
        return cell
    }
}
