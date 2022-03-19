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
    
    func testBackButtonPressed() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["PokeDexIOS.PokedexView"].buttons["Item"].tap()
    }
    
    func testSwipeRightGesture() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.swipeRight()
    }
    
    func testFavouritesButtonClicked() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let pokedexiosPokedexviewNavigationBar = XCUIApplication().navigationBars["PokeDexIOS.PokedexView"]
        pokedexiosPokedexviewNavigationBar.buttons["All"].tap()
        pokedexiosPokedexviewNavigationBar.buttons["Favourites"].tap()
    }
    
    func testNextPageButtonPressed() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().buttons["arrow.forward"].tap()

    }

    func testLastPageButtonPressed() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().buttons["tab"].tap()
    }
    
    func testPrevPageButtonPressed() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["arrow.forward"].tap()
        sleep(2)
        app.buttons["arrow.backward"].tap()
    }
    
    func testFirstPageButtonPressed() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["tab"].tap()
        sleep(2)
        app.buttons["arrow.left.to.line.compact"].tap()
    }
    
    func testPokemonPerPageValueChanged() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sliders["11%"].adjust(toNormalizedSliderPosition: 0.9)
    }
    
    func testSelectTableViewRow() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["1"]/*[[".cells.staticTexts[\"1\"]",".staticTexts[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testSearchBarSearchButtonClickedSucess() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.searchFields["Search: Pokemon Name/ID"].tap()
        app.searchFields["Search: Pokemon Name/ID"].typeText("pikachu")
        app.searchFields["Search: Pokemon Name/ID"].tap()
        XCUIApplication().keyboards.buttons["Search"].tap()
    }
    
    func testSearchBarSearchButtonClickedFailed() throws {
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Browse Pokedex"]/*[[".buttons[\"Browse Pokedex\"].staticTexts[\"Browse Pokedex\"]",".staticTexts[\"Browse Pokedex\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.searchFields["Search: Pokemon Name/ID"].tap()
        app.searchFields["Search: Pokemon Name/ID"].typeText("abcdef")
        app.searchFields["Search: Pokemon Name/ID"].tap()
        XCUIApplication().keyboards.buttons["Search"].tap()
    }
    
}
