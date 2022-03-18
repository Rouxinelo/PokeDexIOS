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
        app.scrollViews.otherElements.buttons["App & Dev Info"].tap()
        app.navigationBars["PokeDexIOS.AboutMeView"].buttons["Item"].tap()
    }
    
    func testSwipeRightGestureHandler() throws {
        app.scrollViews.otherElements.buttons["App & Dev Info"].tap()
        app.staticTexts["Age"].swipeRight()
    
    }
}
