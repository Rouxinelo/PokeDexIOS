//
//  MainMenuViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 18/03/2022.
//

import UIKit
import AVFoundation

class MainMenuViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var songStackView: UIStackView!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var appearanceStackView: UIStackView!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var modeSwitch: UISwitch!
    
    @IBOutlet weak var pokedexButton: UIButton!
    @IBOutlet weak var randomPokemonButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    
    // MARK: - Local Variables
    
    var player: AVAudioPlayer!
    var isPlaying = false
    
    let networkLayer = NetworkLayer()
    let parser = ParseData()
    
    var specieCount: Int = 0
    var randomPokemon: Pokemon?
    
    // MARK: - IBActions
    
    @IBAction func playButtonClicked(_ sender: UIButton) {
        switch sender.currentImage {
        case UIImage(systemName: "play.fill"):
            sender.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            playSound(soundName: K.audioPlayer.themeSongName)
        default:
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
            pauseSound()
        }
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        stopSound()
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
    
    @IBAction func randomPokemonClicked(_ sender: UIButton) {
        loadingIndicator()
        getSpecies()
    }
    
    @IBAction func aboutButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.mainMenuToAboutMe, sender: self)
    }
    
    // MARK: - Network Requests
    
    func getSpecies(){
        
        networkLayer.requestAPI(api: API.GetSpecies("0", "1"), parameters: API.GetSpecies("0", "1").params, headers: API.GetSpecies("0", "1").header, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                if let results = results {
                    
                    let pokedex = self.parser.parsePokeData(Data: results)
                    
                    if pokedex != nil {
                        self.specieCount = pokedex!.count
                        
                        let randomNum = Int.random(in: 1...pokedex!.count)
                        self.getRandomPokemon(number: randomNum)
                    }
                }
            case .error(let error):
                print(error)
            }
        })
        
    }
    
    func getRandomPokemon(number: Int) {
        
        self.networkLayer.requestAPI(api: API.GetPokemonInfo(String(number)), parameters: API.GetPokemonInfo(String(number)).params, headers: API.GetPokemonInfo(String(number)).header, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let results):
                if let results = results {
                    
                    let pokemon = self.parser.parsePokemon(Data: results)
                    if let pokemon = pokemon{
                        
                        self.randomPokemon = pokemon
                        self.removeLoading()
                    }
                }
                
            case .error(let error):
                print(error)
            }
        })
    }
    
    // MARK: - Other functions
    
    func playSound(soundName: String) {
        if !isPlaying {
            let url = Bundle.main.url(forResource: soundName, withExtension: K.audioPlayer.themeSongExtension)
            player = try! AVAudioPlayer(contentsOf: url!)
            player.delegate = self
        }
        player.play()
        isPlaying = true
    }
    
    func pauseSound() {
        if isPlaying {
            player.pause()
        }
    }
    
    func stopSound() {
        if player != nil {
            player.stop()
            isPlaying = false
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    func loadingIndicator(){
        let alert = UIAlertController(title: nil, message: "Fetching Pokemon...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func removeLoading(){
        dismiss(animated: false, completion: {
            self.performSegue(withIdentifier: K.Segues.mainMenuToPokemonStats, sender: self)
        })
    }
    
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
    
    func stylePage() {
        
        contentStackView.layer.cornerRadius = 30
        
        appearanceStackView.layer.borderWidth = 3.0
        appearanceStackView.layer.cornerRadius = 30
        
        songStackView.layer.borderWidth = 3.0
        songStackView.layer.cornerRadius = 30
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        
        pokedexButton.layer.borderWidth = 3.0
        pokedexButton.layer.cornerRadius = 30
        
        randomPokemonButton.layer.borderWidth = 3.0
        randomPokemonButton.layer.cornerRadius = 30
        
        aboutButton.layer.borderWidth = 3.0
        aboutButton.layer.cornerRadius = 30
    }
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setSwitch()
        stylePage()
        
    }
    
}

// MARK: - Prepare for segue to Pokemon Stats

extension MainMenuViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.mainMenuToPokemonStats {
            let VC = segue.destination as! PokemonStatsViewController
            if let pokemon = randomPokemon {
                VC.chosenPokemon = pokemon
            }
        }
    }
}

extension MainMenuViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            player.stop()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            isPlaying = false
        }
    }
}
