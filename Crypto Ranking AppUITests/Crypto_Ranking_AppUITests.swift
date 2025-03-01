//
//  Crypto_Ranking_AppUITests.swift
//  Crypto Ranking AppUITests
//
//  Created by Martha Nashipae on 20/02/2025.
//

import XCTest

class Crypto_Ranking_AppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testSwipeToFavorite() {
        let app = XCUIApplication()
        app.launch()
        
        let firstCell = app.tables.cells.element(boundBy: 0)
        
        if firstCell.exists {
            firstCell.swipeLeft()
            firstCell.buttons["Favorite"].tap()
            
            // Verify the favorite action worked
            let favoritesTab = app.tabBars.buttons["Favorites"]
            favoritesTab.tap()
            
            XCTAssertTrue(app.tables.cells.element(boundBy: 0).exists, "Favorite should be added")
        }
    }
    
    func testPagination() {
        let app = XCUIApplication()
        app.launch()
        
        let tableView = app.tables.firstMatch
        XCTAssertTrue(tableView.exists, "TableView should be present")
        
        let firstCell = tableView.cells.element(boundBy: 0)
        let lastCell = tableView.cells.element(boundBy: 19)
        
        XCTAssertTrue(firstCell.exists, "First page should be loaded")
        
        tableView.swipeUp()
        
        let newCell = tableView.cells.element(boundBy: 20)
        XCTAssertTrue(newCell.exists, "Next page should load on scroll")
    }
}
