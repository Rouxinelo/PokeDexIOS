//
//  PokedexViewControllerUITests.swift
//  PokeDexIOSUITests
//
//  Created by Joao Rouxinol on 10/03/2022.
//

import XCTest

class PokedexViewControllerUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {

        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testInformationClicked() throws {
        XCUIApplication().navigationBars["PokeDexIOS.PokedexView"].buttons["Item"].tap()
    }
    
    func testFavouritesButtonClicked() throws {
        let pokedexiosPokedexviewNavigationBar = XCUIApplication().navigationBars["PokeDexIOS.PokedexView"]
        pokedexiosPokedexviewNavigationBar.buttons["All"].tap()
        pokedexiosPokedexviewNavigationBar.buttons["Favourites"].tap()
    }
    
    func testPageButtonPressed() throws {
        let app = XCUIApplication()
        app.buttons["arrow.forward"].tap()
        app.buttons["tab"].tap()
        app.buttons["arrow.backward"].tap()
        app.buttons["arrow.left.to.line.compact"].tap()
    }
    
    func testPokemonPerPageValueChanged() throws {
        
        let app = XCUIApplication()
        let slider = app.sliders["67%"]

        slider.adjust(toNormalizedSliderPosition: 0.9)
    }
    
    func testPokemonNotFound() throws {
        XCUIApplication().searchFields["Search: Pokemon Name/ID"].tap()
    }
    
    func testSelectTableViewRow() throws {
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["1"]/*[[".cells.staticTexts[\"1\"]",".staticTexts[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testSearchBarSearchButtonClickedSucess() throws {
        let app = XCUIApplication()
        app.searchFields["Search: Pokemon Name/ID"].tap()
        app.searchFields["Search: Pokemon Name/ID"].typeText("pikachu")
        app.searchFields["Search: Pokemon Name/ID"].tap()
        XCUIApplication().keyboards.buttons["Search"].tap()
    }
    
    func testSearchBarSearchButtonClickedFailed() throws {
        let app = XCUIApplication()
        app.searchFields["Search: Pokemon Name/ID"].tap()
        app.searchFields["Search: Pokemon Name/ID"].typeText("abcdef")
        app.searchFields["Search: Pokemon Name/ID"].tap()
        XCUIApplication().keyboards.buttons["Search"].tap()
    }
    
}
