//
//  MoveStatsViewControllerUnitTests.swift
//  PokeDexIOSTests
//
//  Created by Joao Rouxinol on 18/03/2022.
//

import XCTest
@testable import PokeDexIOS

class MoveStatsViewControllerUnitTests: XCTestCase {

    var sut: MoveStatsViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MoveStatsViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testParsePokeDataFails() {
        let entries = [FlavorTextEntries]()
        let result = sut.searchForEnglishDescription(entries: entries)
        XCTAssertEqual(result, "No description available")
    }

}
