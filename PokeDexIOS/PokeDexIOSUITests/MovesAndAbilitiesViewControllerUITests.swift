//
//  MovesAndAbilitiesViewControllerUITests.swift
//  PokeDexIOSUITests
//
//  Created by Joao Rouxinol on 13/03/2022.
//

import XCTest

class MovesAndAbilitiesViewControllerUITests: XCTestCase {


    var app: XCUIApplication!
    
    override func setUpWithError() throws {

        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testBackButtonPressed() throws {
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Bulbasaur"]/*[[".cells.staticTexts[\"Bulbasaur\"]",".staticTexts[\"Bulbasaur\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.PokemonStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 2).tap()
        app.navigationBars["PokeDexIOS.MovesAndAbilitiesView"].buttons["Back"].tap()
    }

    func testSwipeRightGesture() throws {
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Bulbasaur"]/*[[".cells.staticTexts[\"Bulbasaur\"]",".staticTexts[\"Bulbasaur\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.PokemonStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 2).tap()
        app.staticTexts["Move"].swipeRight()
    }
    
    func testClickedOnTableViewCell() throws {
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["1"]/*[[".cells.staticTexts[\"1\"]",".staticTexts[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.PokemonStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 2).tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Amnesia"]/*[[".cells.staticTexts[\"Amnesia\"]",".staticTexts[\"Amnesia\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testPokemonHasNoMoves() throws {
        app.searchFields["Search: Pokemon Name/ID"].tap()
        app.searchFields["Search: Pokemon Name/ID"].typeText("10200")
        app.searchFields["Search: Pokemon Name/ID"].tap()
        XCUIApplication().keyboards.buttons["Search"].tap()
        app.navigationBars["PokeDexIOS.PokemonStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 2).tap()
        app.alerts["Oh No!"].scrollViews.otherElements.buttons["Return"].tap()
    }
}
