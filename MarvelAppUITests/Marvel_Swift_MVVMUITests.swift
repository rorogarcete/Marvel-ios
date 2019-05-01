//
//  Marvel_Swift_MVVMUITests.swift
//  Marvel-Swift-MVVMUITests
//
//  Created by Felipe Silva  on 4/5/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import XCTest
@testable import MarvelApp

class Marvel_Swift_MVVMUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUI() {
        
        var app = XCUIApplication()
        
        sleep(2)
        
        app = testCharactersVC(app: app)
        
        sleep(1)
        
        app = testCharDetailVC(app: app)
        
    }
    
    private func testCharactersVC(app : XCUIApplication) -> XCUIApplication{
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeUp()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeUp()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeDown()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeDown()
        
        app.collectionViews.cells.element(boundBy: 0).tap()
        
        return app
    }
    
    private func testCharDetailVC(app : XCUIApplication) -> XCUIApplication{
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeUp()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeDown()

        return app
    }

    
}
