//
//  Tests_macOS.swift
//  Tests macOS
//
//  Created by Bri on 12/5/21.
//

import XCTest

class Tests_macOS: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGoldenPath() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let window = XCUIApplication().windows["iCone"]
        window.buttons["File Picker"].click()
        
        window.typeKey(.downArrow, modifierFlags:.function)
        window.typeKey(.return, modifierFlags:.function)
        
        window.tables.buttons["Document Picker"].click()
        window.typeKey(.return, modifierFlags:.function)
        
        window.tables.children(matching: .tableRow).element(boundBy: 3).cells.children(matching: .popUpButton).element.click()
        window.tables.menuItems["iOS"].click()
        window.buttons["Go"].click()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
