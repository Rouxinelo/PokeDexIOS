//
//  MainMenuViewControllerUITests.swift
//  PokeDexIOSUITests
//
//  Created by Joao Rouxinol on 18/03/2022.
//

import XCTest

class MainMenuViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {

        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testPlayButtonClicked() throws {
        let elementsQuery = XCUIApplication().scrollViews.otherElements
        elementsQuery.buttons["play"].tap()
        elementsQuery.buttons["pause"].tap()
    }
    

    func testStopButtonClickedWithoutPlayer() throws {
        XCUIApplication().scrollViews.otherElements.buttons["Stop"].tap()
    }
    
    func testStopButtonClickedWithPlayer() throws {
        let elementsQuery = XCUIApplication().scrollViews.otherElements
        elementsQuery.buttons["play"].tap()
        elementsQuery.buttons["Stop"].tap()
    }
    
    func testBrowsePokedex() throws {
        XCUIApplication().scrollViews.otherElements.buttons["Browse Pokedex"].tap()
    }
    
    func testSearchRandom() throws {
        XCUIApplication().scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Search Random Pokemon"]/*[[".buttons[\"Search Random Pokemon\"].staticTexts[\"Search Random Pokemon\"]",".staticTexts[\"Search Random Pokemon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testInfoButton() throws {
        XCUIApplication().scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["App & Dev Info"]/*[[".buttons[\"App & Dev Info\"].staticTexts[\"App & Dev Info\"]",".staticTexts[\"App & Dev Info\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
