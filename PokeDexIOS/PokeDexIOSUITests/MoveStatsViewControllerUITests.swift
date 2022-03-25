//
//  MoveStatsViewControllerUITests.swift
//  PokeDexIOSUITests
//
//  Created by Joao Rouxinol on 12/03/2022.
//

import XCTest

class MoveStatsViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    
    override func setUpWithError() throws {

        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testBackButtonPressed() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Bulbasaur"]/*[[".cells.staticTexts[\"Bulbasaur\"]",".staticTexts[\"Bulbasaur\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.PokemonStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 2).tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Amnesia"]/*[[".cells.staticTexts[\"Amnesia\"]",".staticTexts[\"Amnesia\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.MoveStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 0).tap()

    }

    func testHomeButtonPressed() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Bulbasaur"]/*[[".cells.staticTexts[\"Bulbasaur\"]",".staticTexts[\"Bulbasaur\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.PokemonStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 2).tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Amnesia"]/*[[".cells.staticTexts[\"Amnesia\"]",".staticTexts[\"Amnesia\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.MoveStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 1).tap()

    }
}
