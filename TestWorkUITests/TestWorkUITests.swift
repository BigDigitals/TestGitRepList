//
//  TestWorkUITests.swift
//  TestWorkUITests
//
//  Created by anton on 11/30/17.
//  Copyright © 2017 Artem Melnyk. All rights reserved.
//

import XCTest

class TestWorkUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testApplication() {
        // Add search text
        let app = XCUIApplication()
        let textField = app.searchFields.element(boundBy: 0)
        XCTAssertTrue(textField.exists, "Text field doesn't exist")
        textField.tap()
        textField.typeText("Tetris")
        XCTAssertEqual(textField.value as! String, "Tetris", "Text field value is not correct")
        sleep(1)
        textField.typeText("\n")
        
        sleep(2)
        
        // Swipe Table View
        
        var tablesQuery = XCUIApplication().tables
        var tableElement = tablesQuery.element
        tableElement.swipeUp()
        tableElement.swipeUp()
        sleep(1)
        
        // Tap Table View cell
        let cell = tableElement.cells.element(matching: .cell, identifier: "ListCell_10")
        cell.tap()
        
        sleep(1)
        
        // Swipe Table View
        
        tablesQuery = XCUIApplication().tables
        tableElement = tablesQuery.element
        tableElement.swipeUp()
        tableElement.swipeUp()
        tableElement.swipeUp()
        
        sleep(1)
    }
    
}
