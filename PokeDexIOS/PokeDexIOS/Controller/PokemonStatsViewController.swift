//
//  PokemonStatsViewController.swift
//  PokeDexIOS
//
//  Created by Joao Rouxinol on 25/02/2022.
//

import UIKit
import CoreData
import AVFoundation

    // MARK: - Delegate Protocol

protocol PokemonStatsViewControllerDelegate{
    func didRemoveFromFavourites(pokemon: pokemon)
}

class PokemonStatsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
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
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    // MARK: - Local variables
    
    var delegate: PokemonStatsViewControllerDelegate?
    
    // Music player
    var player: AVAudioPlayer!

    // Handles the POST request to the Webhook
    var webhookHandler = WebhookRequest()
    
    // Pokemon to be displayed
    var chosenPokemon: pokemon? = nil
    
    // Array of pokemons marked as favourite
    var favPokemon = [FavPokemon]()
    
    // Color Picker for types
    var colorPicker = TypeColorManager()
    
    // Context for Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Core data functions
    
    // Load the list of favourites
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
    
    // Saves a new favourite
    func savePokemon(){
        do{
            try context.save()
        } catch {
            print("error saving")
        }
    }
    
    // Deletes the pokemon from the favourites list
    func deletePokemon(toDelete: FavPokemon){
        do{
            context.delete(toDelete)
            try context.save()
        } catch {
            print("error deleting")
        }
    }
    
    // MARK: - Button OnClickActions

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        returnToPreviousScreen()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: K.Segues.pokeStatsToMovesAndAbilities, sender: self)
    }
    
    @IBAction func InformationClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.Segues.pokeStatsToAboutMe, sender: sender)
    }
    
    
    @IBAction func favButtonClicked(_ sender: UIBarButtonItem) {
        // Alert to be shown
        let alertController = UIAlertController(title: "", message:
                                                    "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        alertController.message = chosenPokemon!.name.capitalizingFirstLetter()
        
        switch sender.image{
        
        // Pokemon was not a favourite yet
        case K.BarButton.notFav:
            
            playSound(soundName: K.audioPlayer.favouriteSoundName)
            
            sender.image = K.BarButton.fav
            
            if let pokemon = chosenPokemon{
                
                // Save the favourite on CoreData
                let newFavPokemon = FavPokemon(context: context)
                newFavPokemon.name = pokemon.name
                newFavPokemon.id = Int64((pokemon.id))
                favPokemon.append(newFavPokemon)
                savePokemon()
                
                // Send the POST request to the Webhook
                var favWebhookRequest = WebhookData()
                favWebhookRequest.name = pokemon.name
                favWebhookRequest.id = pokemon.id
                favWebhookRequest.op = "ADD"
                webhookHandler.webhookData = favWebhookRequest
                webhookHandler.sendData()
                
            }
            
            alertController.title = "Favourite Added:"
            self.present(alertController, animated: true, completion: nil)
            
        // Pokemon was marked as favourite
        case K.BarButton.fav:
            sender.image = K.BarButton.notFav

            for pokemon in favPokemon{
                if pokemon.name == chosenPokemon?.name{
                    // Remove pokemon fro CoreData
                    deletePokemon(toDelete: pokemon)
                    
                    // Send the POST request to the Webhook
                    var favWebhookRequest = WebhookData()
                    favWebhookRequest.name = chosenPokemon?.name
                    favWebhookRequest.id = chosenPokemon?.id
                    favWebhookRequest.op = "REMOVE"
                    webhookHandler.webhookData = favWebhookRequest
                    webhookHandler.sendData()
                }
            }
            alertController.title = "Favourite Removed:"
            self.present(alertController, animated: true, completion: nil)
            
        default:
            return
        }
    }
    
    // MARK: - Pokemon Sprite TapGestureRecognizer
    
    // Tapped on the Pokemon Sprite, change from regular to shiny
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if let pokemon = chosenPokemon{
                switch imageTextLabel.text{
                case "Regular":
                    if let shiny = pokemon.sprites.front_shiny {
                        pokemonImage.load(url: URL(string: shiny)!)
                        imageTextLabel.text = "Shiny"
                    }
                    break
                case "Shiny":
                    pokemonImage.load(url: URL(string: pokemon.sprites.front_default)!)
                    imageTextLabel.text = "Regular"
                    break
                default:
                    print("Error")
                }
            }
        }
    }
    

    // MARK: - Gesture handlers
    
    func defineImageTapGesture(){
        let tapPokemonImage = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        
        pokemonImage.addGestureRecognizer(tapPokemonImage)
        pokemonImage.isUserInteractionEnabled = true
    }
    
    
    func defineSwipeGesture(){
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer){
        if gesture.direction == .right {
            returnToPreviousScreen()
        }
        
        if gesture.direction == .left {
            performSegue(withIdentifier: K.Segues.pokeStatsToMovesAndAbilities, sender: self)
        }
    }
    
    
    // MARK: - Styling the view with the pokemon stats
    
    // Adds style to a type label
    func styleTypeLabel(label: UILabel, fontColor: UIColor, backgroundColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat, text: String){
        label.textColor = fontColor
        label.backgroundColor  = backgroundColor
        label.layer.borderWidth = borderWidth
        label.layer.cornerRadius = cornerRadius
        label.text = text
        label.layer.masksToBounds = true
    }
    
    func setStatLabels(pokemonStat:[possibleStat]){
        hpLabel.text = String(pokemonStat[0].base_stat)
        atkLabel.text = String(pokemonStat[1].base_stat)
        defLabel.text = String(pokemonStat[2].base_stat)
        spAtkLabel.text = String(pokemonStat[3].base_stat)
        spDefLabel.text = String(pokemonStat[4].base_stat)
        speedLabel.text = String(pokemonStat[5].base_stat)
    }
    
    func setPageHeader(pokemon: pokemon){
        
        colorPicker.type = pokemon.types.first?.type.name

        pokemonColor
            .backgroundColor = colorPicker.getColorForType()
        
        
        pokemonColor.clipsToBounds = true
        pokemonColor.layer.cornerRadius = 28
        pokemonColor.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        pokemonName.textColor = colorPicker.getTextFontColor()
        pokemonName.text = pokemon.name.capitalizingFirstLetter()
        
        pokemonNumber.textColor = colorPicker.getTextFontColor()
        pokemonNumber.text = String(pokemon.id)
        
        pokemonImage.load(url: URL(string: pokemon.sprites.front_default)!)
        pokemonImage.layer.cornerRadius = K.StatsScreen.spriteRadius
        pokemonImage.layer.borderWidth = K.StatsScreen.spriteStrokeWidth

        imageTextLabel.textColor = colorPicker.getTextFontColor()
    }
    
    func setPageFooter(pokemon: pokemon){
        
        pokemonWeight.text = getStatWithUnits(stat: "wt", value: pokemon.weight)
        pokemonHeight.text = getStatWithUnits(stat: "ht", value: pokemon.height)
        baseEXP.text = String(pokemon.base_experience)
        
        colorPicker.type = pokemon.types.first?.type.name
        styleTypeLabel(label: type1Label, fontColor: colorPicker.getTextFontColor(), backgroundColor: colorPicker.getColorForType(), borderWidth: K.StatsScreen.strokeWidth, cornerRadius: K.StatsScreen.borderRadius, text: (pokemon.types.first?.type.name)!)
        
        if pokemon.types.count > 1{
            type2Label.isHidden = false
            colorPicker.type = pokemon.types.last?.type.name
            styleTypeLabel(label: type2Label, fontColor: colorPicker.getTextFontColor(), backgroundColor: colorPicker.getColorForType(), borderWidth: K.StatsScreen.strokeWidth, cornerRadius: K.StatsScreen.borderRadius, text: (pokemon.types.last?.type.name)!)
        }
        
        setStatLabels(pokemonStat: pokemon.stats)
    }
    
    func setFavouriteButton(pokemon: pokemon){
        
        loadPokemon()
        
        for fav in favPokemon{
            if fav.name == chosenPokemon?.name{
                favButton.image = K.BarButton.fav
                break
            }
        }
    }

    // MARK: - Other functions
    
    func getStatWithUnits(stat: String, value: Int) -> String {
        let toReturn = (Float(value) / 10.0)
        if stat == "ht" {
            return String(toReturn) + " m"
        } else if stat == "wt" {
            return String(toReturn) + " kg"
        }
        return "???"
    }
    
    // Plays an .mp3 sound passed as argument
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: K.audioPlayer.favouriteSoundExtension)
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    func returnToPreviousScreen(){
        if favButton.image == K.BarButton.notFav{
            delegate?.didRemoveFromFavourites(pokemon: chosenPokemon!)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pokemon = chosenPokemon{
            setPageHeader(pokemon: pokemon)
            setPageFooter(pokemon: pokemon)
            setFavouriteButton(pokemon: pokemon)
        }

        defineImageTapGesture()
        
        defineSwipeGesture()

    }
    
}

// MARK: - Prepare for Segue to MovesAndAbilities

extension PokemonStatsViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.pokeStatsToMovesAndAbilities {
            
            if let VC = segue.destination as? MovesAndAbilitiesViewController{
                if let pokemon = chosenPokemon{
                    VC.chosenPokemon = pokemon
                }
            }
        }
    }
}

