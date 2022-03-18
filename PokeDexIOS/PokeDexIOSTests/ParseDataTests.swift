//
//  ParseDataTests.swift
//  PokeDexIOSTests
//
//  Created by Joao Rouxinol on 18/03/2022.
//

import XCTest
@testable import PokeDexIOS

class ParseDataTests: XCTestCase {

    var sut: ParseData!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ParseData()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testParsePokeDataFails() {
        let data = Data(capacity: 10)
        let result = sut.parsePokeData(Data: data)
        XCTAssertNil(result, "Works")
    }

    func testParsePokemonFails() {
        let data = Data(capacity: 10)
        let result = sut.parsePokemon(Data: data)
        XCTAssertNil(result, "Works")
    }
    
    func testParsePokemonMoveFails() {
        let data = Data(capacity: 10)
        let result = sut.parsePokemonMove(Data: data)
        XCTAssertNil(result, "Works")
    }
    
}
