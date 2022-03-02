//
//  PokemonStatsViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 25/02/2022.
//

import UIKit
import CoreData
import AVFoundation

class PokemonStatsViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var favButton: UIBarButtonItem!
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var imageTextLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonColor: UIStackView!
    @IBOutlet weak var pokemonHeight: UILabel!
    @IBOutlet weak var pokemonWeight: UILabel!
    @IBOutlet weak var baseEXP: UILabel!
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var atkLabel: UILabel!
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var spAtkLabel: UILabel!
    @IBOutlet weak var spDefLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    // Music player
    var player: AVAudioPlayer!

    // Handles the POST request to the Webhook
    var webhookHandler = WebhookRequest()
    
    // Pokemon to be displayed
    var chosenPokemon: pokemon? = nil
    
    // Array of pokemons marked as favourite
    var favPokemon = [FavPokemon]()
    
    // Image that is displayed (normal or shiny)
    var displayedImage: String? = nil
    
    // Colors
    var type1FontColor: UIColor = .black
    var type1Color: UIColor = .white
    var type2FontColor: UIColor = .black
    var type2Color: UIColor = .white
    
    // Context for Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    // Bar Button OnClickActions
    @IBAction func InformationClicked(_ sender: Any) {
        performSegue(withIdentifier: K.Segues.pokeStatsToAboutMe, sender: sender)
    }
    
    @IBAction func favButtonClicked(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "", message:
                                                    "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        alertController.message = chosenPokemon!.name
        
        switch sender.image{
        case K.BarButton.notFav:
            sender.image = K.BarButton.fav
            
            playSound(soundName: K.audioPlayer.favouriteSoundName)
            
            let newFavPokemon = FavPokemon(context: context)
            newFavPokemon.name = chosenPokemon?.name
            newFavPokemon.id = Int64((chosenPokemon?.id)!)
            favPokemon.append(newFavPokemon)
            
            savePokemon()
            
            alertController.title = "Favourite Added:"
            self.present(alertController, animated: true, completion: nil)
            
        case K.BarButton.fav:
            sender.image = K.BarButton.notFav

            for pokemon in favPokemon{
                if pokemon.name == chosenPokemon?.name{
                    deletePokemon(toDelete: pokemon)
                }
            }
            alertController.title = "Favourite Removed:"
            self.present(alertController, animated: true, completion: nil)
            
        default:
            return
        }
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: K.audioPlayer.favouriteSoundExtension)
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    func loadPokemon(){
        let request: NSFetchRequest<FavPokemon> = FavPokemon.fetchRequest()
        do {
            
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            let sortDescriptors = [sortDescriptor]
            request.sortDescriptors = sortDescriptors
            
            favPokemon = try context.fetch(request)
        } catch {
            print ("error loading")
        }
    }
    
    func savePokemon(){
        do{
            try context.save()
        } catch {
            print("error saving")
        }
    }
    
    func deletePokemon(toDelete: FavPokemon){
        do{
            context.delete(toDelete)
            try context.save()
        } catch {
            print("error deleting")
        }
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if let pokemon = chosenPokemon{
                switch displayedImage{
                case "Regular":
                    if let shiny = pokemon.sprites.front_shiny {
                        pokemonImage.load(url: URL(string: shiny)!)
                        imageTextLabel.text = "Shiny"
                        displayedImage = "Shiny"
                    }
                    break
                case "Shiny":
                    pokemonImage.load(url: URL(string: pokemon.sprites.front_default)!)
                    imageTextLabel.text = "Regular"
                    displayedImage = "Regular"
                    break
                default:
                    print("Error")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pokemon = chosenPokemon{
            pokemonColor
                .backgroundColor = type1Color
            
            pokemonName.textColor = type1FontColor
            pokemonName.text = pokemon.name
            
            pokemonNumber.textColor = type1FontColor
            pokemonNumber.text = String(pokemon.id)
            
            pokemonImage.load(url: URL(string: pokemon.sprites.front_default)!)
            pokemonImage.layer.cornerRadius = K.StatsScreen.spriteRadius
            pokemonImage.layer.borderWidth = K.StatsScreen.spriteStrokeWidth

            imageTextLabel.textColor = type1FontColor
            
            pokemonWeight.text = String(pokemon.weight)
            pokemonHeight.text = String(pokemon.height)
            baseEXP.text = String(pokemon.base_experience)
            
            type1Label.layer.borderWidth = K.StatsScreen.strokeWidth
            type1Label.layer.cornerRadius = K.StatsScreen.borderRadius
            type1Label.layer.masksToBounds = true
            type1Label.text = pokemon.types.first?.type.name
            type1Label.textColor = type1FontColor
            type1Label.backgroundColor  = type1Color
            
            // In case the pokemon has two types
            if pokemon.types.count > 1{
                type2Label.layer.masksToBounds = true
                type2Label.layer.borderWidth = K.StatsScreen.strokeWidth
                type2Label.layer.cornerRadius = K.StatsScreen.borderRadius
                type2Label.isHidden = false
                
                type2Label.text = pokemon.types.last?.type.name
                type2Label.textColor = type2FontColor
                type2Label.backgroundColor  = type2Color
                
                // Pokemon only has 1 type
            } else {
                type2Label.isHidden = true
            }
            
            hpLabel.text = String(pokemon.stats[0].base_stat)
            atkLabel.text = String(pokemon.stats[1].base_stat)
            defLabel.text = String(pokemon.stats[2].base_stat)
            spAtkLabel.text = String(pokemon.stats[3].base_stat)
            spDefLabel.text = String(pokemon.stats[4].base_stat)
            speedLabel.text = String(pokemon.stats[5].base_stat)
            
            let tapPokemonImage = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
            
            pokemonImage.addGestureRecognizer(tapPokemonImage)
            pokemonImage.isUserInteractionEnabled = true
            
            loadPokemon()
            
            for fav in favPokemon{
                if fav.name == chosenPokemon?.name{
                    favButton.image = K.BarButton.fav
                }
            }
        }
    }
    
}
