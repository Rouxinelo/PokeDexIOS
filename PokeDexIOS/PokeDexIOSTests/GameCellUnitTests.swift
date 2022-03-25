//
//  GameCellUnitTests.swift
//  PokeDexIOSTests
//
//  Created by Joao Rouxinol on 25/03/2022.
//

import XCTest
@testable import PokeDexIOS

class GameCellUnitTests: XCTestCase {

    var sut: GameCell!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = GameCell()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testGameNameSetupFireRedSuccess() {
        let result = sut.gameNameSetup(name: "firered")
        XCTAssertEqual(result, "Fire Red")
    }

    func testGameNameSetupLeafGreenSuccess() {
        let result = sut.gameNameSetup(name: "leafgreen")
        XCTAssertEqual(result, "Leaf Green")
    }
    
    func testGameNameSetupHeartGoldSuccess() {
        let result = sut.gameNameSetup(name: "heartgold")
        XCTAssertEqual(result, "Heart Gold")
    }
    
    func testGameNameSetupSoulSilverSuccess() {
        let result = sut.gameNameSetup(name: "soulsilver")
        XCTAssertEqual(result, "Soul Silver")
    }
    
    func testGameNameSetupBlack2Success() {
        let result = sut.gameNameSetup(name: "black-2")
        XCTAssertEqual(result, "Black 2")
    }
    
    func testGameNameSetupWhite2Success() {
        let result = sut.gameNameSetup(name: "white-2")
        XCTAssertEqual(result, "White 2")
    }
}
