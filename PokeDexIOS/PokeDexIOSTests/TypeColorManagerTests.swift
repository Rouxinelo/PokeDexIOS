//
//  TypeColorManagerTests.swift
//  PokeDexIOSTests
//
//  Created by Joao Rouxinol on 09/03/2022.
//

import XCTest
@testable import PokeDexIOS

class TypeColorManagerTests: XCTestCase {

    var sut: TypeColorManager!
    let cons = 255.0
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TypeColorManager()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
    }
    
    func testGetColorForTypeBugPasses(){
        let color = UIColor(displayP3Red: 221.0/cons, green: 255.0/cons, blue: 0, alpha: 1)
        sut.type = "bug"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeElectricPasses(){
        let color = UIColor(displayP3Red: 255.0/cons, green: 247.0/cons, blue: 0, alpha: 1)
        sut.type = "electric"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }

    func testGetColorForTypeFirePasses(){
        let color = UIColor(displayP3Red: 255.0/cons, green: 0, blue: 0, alpha: 1)
        sut.type = "fire"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeGrassPasses(){
        let color = UIColor(displayP3Red: 16.0/cons, green: 138.0/cons, blue: 0, alpha: 1)
        sut.type = "grass"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeNormalPasses(){
        let color = UIColor(displayP3Red: 120.0/cons, green: 120.0/cons, blue: 120.0/cons, alpha: 1)
        sut.type = "normal"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeRockPasses(){
        let color = UIColor(displayP3Red: 117.0/cons, green: 90.0/cons, blue: 61.0/cons, alpha: 1)
        sut.type = "rock"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeDarkPasses(){
        let color = UIColor(displayP3Red: 46.0/cons, green: 41.0/cons, blue: 35.0/cons, alpha: 1)
        sut.type = "dark"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeFairyPasses(){
        let color = UIColor(displayP3Red: 252.0/cons, green: 146.0/cons, blue: 245.0/cons, alpha: 1)
        sut.type = "fairy"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeFlyingPasses(){
        let color = UIColor(displayP3Red: 146.0/cons, green: 198.0/cons, blue: 252.0/cons, alpha: 1)
        sut.type = "flying"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeGroundPasses(){
        let color = UIColor(displayP3Red: 130.0/cons, green: 104.0/cons, blue: 75.0/cons, alpha: 1)
        sut.type = "ground"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypePoisonPasses(){
        let color = UIColor(displayP3Red: 93.0/cons, green: 15.0/cons, blue: 171.0/cons, alpha: 1)
        sut.type = "poison"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeSteelPasses(){
        let color = UIColor(displayP3Red: 90.0/cons, green: 90.0/cons, blue: 90.0/cons, alpha: 1)
        sut.type = "steel"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeDragonPasses(){
        let color = UIColor(displayP3Red: 96.0/cons, green: 67.0/cons, blue: 224.0/cons, alpha: 1)
        sut.type = "dragon"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeFightingPasses(){
        let color = UIColor(displayP3Red: 105.0/cons, green: 47.0/cons, blue: 17.0/cons, alpha: 1)
        sut.type = "fighting"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeGhostPasses(){
        let color = UIColor(displayP3Red: 74.0/cons, green: 57.0/cons, blue: 150.0/cons, alpha: 1)
        sut.type = "ghost"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeIcePasses(){
        let color = UIColor(displayP3Red: 79.0/cons, green: 220.0/cons, blue: 255.0/cons, alpha: 1)
        sut.type = "ice"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypePsychicPasses(){
        let color = UIColor(displayP3Red: 255.0/cons, green: 66.0/cons, blue: 242.0/cons, alpha: 1)
        sut.type = "psychic"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeWaterPasses(){
        let color = UIColor(displayP3Red: 0, green: 145.0/cons, blue: 255.0/cons, alpha: 1)
        sut.type = "water"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetColorForTypeDefaultPasses(){
        let color = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)
        sut.type = "abcd"
        XCTAssertEqual(sut.getColorForType(), color, "Type Color is Correct")
    }
    
    func testGetTextFontColorCasePasses(){
        let color = UIColor(displayP3Red: 255.0/cons, green: 255.0/cons, blue: 255.0/cons, alpha: 1)
        sut.type = "poison"
        XCTAssertEqual(sut.getTextFontColor(), color, "Type Font Color is Correct")
    }
    
    func testGetTextFontColorDefaultPasses(){
        let color = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)
        sut.type = "flying"
        XCTAssertEqual(sut.getTextFontColor(), color, "Type Font Color is Correct")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
