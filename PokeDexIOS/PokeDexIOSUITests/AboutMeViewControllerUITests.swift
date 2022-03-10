//
//  AboutMeViewControllerUITests.swift
//  PokeDexIOSUITests
//
//  Created by Joao Rouxinol on 10/03/2022.
//

import XCTest

class AboutMeViewControllerUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {

        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testBackButtonPressed() throws {
        let app = XCUIApplication()
        app.navigationBars["PokeDexIOS.PokedexView"].buttons["Item"].tap()
        app.navigationBars["PokeDexIOS.AboutMeView"].buttons["Item"].tap()
    }
    
    func testSwipeRightGestureHandler() throws {
        
        let app = XCUIApplication()
        app.navigationBars["PokeDexIOS.PokedexView"].buttons["Item"].tap()
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).swipeRight()
        
    }
}
