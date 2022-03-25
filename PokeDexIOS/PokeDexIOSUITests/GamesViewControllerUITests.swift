//
//  GamesViewControllerUITests.swift
//  PokeDexIOSUITests
//
//  Created by Joao Rouxinol on 25/03/2022.
//

import XCTest

class GamesViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {

        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testBackButton() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Bulbasaur"]/*[[".cells.staticTexts[\"Bulbasaur\"]",".staticTexts[\"Bulbasaur\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.PokemonStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 2).tap()
        app.navigationBars["PokeDexIOS.MovesAndAbilitiesView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 1).tap()
        app.navigationBars["PokeDexIOS.GamesView"].buttons["Back"].tap()
    }
    
    func testSwipeRight() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Bulbasaur"]/*[[".cells.staticTexts[\"Bulbasaur\"]",".staticTexts[\"Bulbasaur\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.PokemonStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 2).tap()
        app.navigationBars["PokeDexIOS.MovesAndAbilitiesView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 1).tap()
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).swipeRight()
    }
    
    func testHomeButton() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Bulbasaur"]/*[[".cells.staticTexts[\"Bulbasaur\"]",".staticTexts[\"Bulbasaur\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.PokemonStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 2).tap()
        app.navigationBars["PokeDexIOS.MovesAndAbilitiesView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 1).tap()
        app.navigationBars["PokeDexIOS.GamesView"].buttons["Item"].tap()
        
    }
    
}
