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
    
    let test: [String] = ["Abc", "Bcd", "Def"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moveTableCell.dataSource = self
        
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
