//
//  MainMenuViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 18/03/2022.
//

import UIKit

class MainMenuViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var songStackView: UIStackView!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var appearanceStackView: UIStackView!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var modeSwitch: UISwitch!
    
    // MARK: - IBActions
   
    @IBAction func playButtonClicked(_ sender: UIButton) {
        switch sender.currentImage {
        case UIImage(systemName: "play.fill"):
            sender.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            default:
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        
    }
    
    @IBAction func switchPressed(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            modeLabel.text = "Dark"
            setMode(mode: .dark)
        default:
            modeLabel.text = "Light"
            setMode(mode: .light)
        }
    }
    
    @IBAction func pokedexButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.mainMenuToPokedex, sender: self)
    }
    
    @IBAction func aboutButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.mainMenuToAboutMe, sender: self)
    }
    
    // MARK: - Other functions
    
    func setMode(mode : UIUserInterfaceStyle) {
        let window = UIApplication.shared.windows[0]
        window.overrideUserInterfaceStyle = mode
    }
    
    func setSwitch() {
        switch UIScreen.main.traitCollection.userInterfaceStyle.rawValue {
        case 1:
            modeLabel.text = "Light"
            modeSwitch.isOn = false
        case 2:
            modeLabel.text = "Dark"
            modeSwitch.isOn = true
        default:
            modeLabel.text = "Light"
            modeSwitch.isOn = false
        }
    }
    
    func styleHeader() {
        appearanceStackView.layer.cornerRadius = 30
        songStackView.layer.cornerRadius = 30
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSwitch()
        styleHeader()
    }
    

}
