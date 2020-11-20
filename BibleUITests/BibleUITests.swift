//
//  BibleUITests.swift
//  BibleUITests
//
//  Created by jge on 2020/11/18.
//  Copyright © 2020 jge. All rights reserved.
//

import XCTest

class BibleUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func test_first_launch_app() {
        let app = XCUIApplication()
        let arrowRightButton = app.buttons["arrow.right"]
        arrowRightButton.tap()
        arrowRightButton.tap()
        arrowRightButton.tap()
        arrowRightButton.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.images["Loading"].swipeRight()
        elementsQuery.images["Fourth"].swipeRight()
        arrowRightButton.tap()
        arrowRightButton.tap()
        arrowRightButton.tap()
        arrowRightButton.tap()
    }
    
    func test_change_bibleList() {
        let app = XCUIApplication()
        let burgerButton = app.navigationBars["창세기 1장"].buttons["burger"]
        burgerButton.tap()
        burgerButton.tap()
        
        let tablesQuery = app.tables
        tablesQuery.buttons["1, 창세기, 총 50장"].tap()
        app.scrollViews.otherElements.staticTexts["2"].tap()
    }
    
}
