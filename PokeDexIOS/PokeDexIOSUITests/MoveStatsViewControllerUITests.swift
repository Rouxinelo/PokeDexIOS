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
        
        app.scrollViews.otherElements.buttons["Browse Pokedex"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["1"]/*[[".cells.staticTexts[\"1\"]",".staticTexts[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.PokemonStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 2).tap()
        app.tables.cells.containing(.staticText, identifier:"Amnesia").staticTexts["Egg"].tap()
        app.navigationBars["PokeDexIOS.MoveStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 0).tap()
    }

    func testHomeButtonPressed() throws {
        app.scrollViews.otherElements.buttons["Browse Pokedex"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Bulbasaur"]/*[[".cells.staticTexts[\"Bulbasaur\"]",".staticTexts[\"Bulbasaur\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.PokemonStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 2).tap()
        app.navigationBars["PokeDexIOS.MovesAndAbilitiesView"].buttons["Item"].tap()
    }
}
