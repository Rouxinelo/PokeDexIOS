//
//  PokemonStatsViewControllerUITests.swift
//  PokeDexIOSUITests
//
//  Created by Joao Rouxinol on 10/03/2022.
//

import XCTest

class PokemonStatsViewControllerUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {

        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testBackButtonPressed() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"1").element/*[[".cells.containing(.staticText, identifier:\"Bulbasaur\").element",".cells.containing(.staticText, identifier:\"1\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.PokemonStatsView"].buttons["Back"].tap()
    }
    
    func testSwipeRightGestureHandler() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["1"]/*[[".cells.staticTexts[\"1\"]",".staticTexts[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).swipeRight()
    }
    
    func testHomeButtonPressed() throws {
        app.scrollViews.otherElements.buttons["Browse Pokedex"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["1"]/*[[".cells.staticTexts[\"1\"]",".staticTexts[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.PokemonStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 0).tap()
    }
    
    func testInformationClicked() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Bulbasaur"]/*[[".cells.staticTexts[\"Bulbasaur\"]",".staticTexts[\"Bulbasaur\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.PokemonStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 1).tap()
    }
    
    func testFavButtonClicked() throws {
        
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["1"]/*[[".cells.staticTexts[\"1\"]",".staticTexts[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let itemButton = app.navigationBars["PokeDexIOS.PokemonStatsView"].children(matching: .button).matching(identifier: "Item").element(boundBy: 1)
        itemButton.tap()
        app.alerts["Favourite Added:"].scrollViews.otherElements.buttons["Dismiss"].tap()
        itemButton.tap()
        app.alerts["Favourite Removed:"].scrollViews.otherElements.buttons["Dismiss"].tap()

    }
    
    func testimageTapped() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["1"]/*[[".cells.staticTexts[\"1\"]",".staticTexts[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let image = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .image).element
        image.tap()
        image.tap()
    }
    
}
