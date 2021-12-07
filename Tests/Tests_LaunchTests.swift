//
//  Tests_macOSLaunchTests.swift
//  Tests macOS
//
//  Created by Bri on 12/5/21.
//

import XCTest

class Tests_macOSLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app
        
        let window = XCUIApplication().windows["iCone"]
        window.buttons["File Picker"].click()
        
        window.typeKey(.downArrow, modifierFlags:.function)
        window.typeKey(.return, modifierFlags:.function)
        
        window.tables.buttons["Document Picker"].click()
        window.typeKey(.return, modifierFlags:.function)
        
        window.tables.children(matching: .tableRow).element(boundBy: 3).cells.children(matching: .popUpButton).element.click()
        window.tables.menuItems["iOS"].click()
        window.buttons["Go"].click()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
