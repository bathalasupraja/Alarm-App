//
//  Alarm_AppTests.swift
//  Alarm AppTests
//
//  Created by Supraja on 01/11/24.
//

import XCTest
@testable import Alarm_App

final class SchedulerTests: XCTestCase {

    let scheduler = NotificationScheduler()
    
    func testCompareWeekdays() {
        XCTAssertEqual(scheduler.compare(weekday: 1, with: 1), NotificationScheduler.weekdaysComparisonResult.same)
        XCTAssertEqual(scheduler.compare(weekday: 2, with: 2), NotificationScheduler.weekdaysComparisonResult.same)
        XCTAssertEqual(scheduler.compare(weekday: 6, with: 1), NotificationScheduler.weekdaysComparisonResult.before)
        XCTAssertEqual(scheduler.compare(weekday: 2, with: 3), NotificationScheduler.weekdaysComparisonResult.before)
        XCTAssertEqual(scheduler.compare(weekday: 3, with: 2), NotificationScheduler.weekdaysComparisonResult.after)
        XCTAssertEqual(scheduler.compare(weekday: 1, with: 7), NotificationScheduler.weekdaysComparisonResult.after)
    }
}


func constructTestingViews(navDelegate: UINavigationControllerDelegate) -> (UIStoryboard, AppDelegate, UINavigationController, MainAlarmViewController) {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

    let navigationController = storyboard.instantiateViewController(withIdentifier: "navController") as! UINavigationController
    navigationController.delegate = navDelegate
    
    let mainAlarmViewController = navigationController.viewControllers.first as! MainAlarmViewController
    mainAlarmViewController.loadViewIfNeeded()
    
    let window = UIWindow()
    window.rootViewController = mainAlarmViewController
    let appDelegate = AppDelegate()
    appDelegate.window = window
    
    window.makeKeyAndVisible()
    return (storyboard, appDelegate, navigationController, mainAlarmViewController)
}

final class Alarm_AppTests: XCTestCase, UINavigationControllerDelegate {
    
    var storyboard: UIStoryboard! = nil
    var appDelegate: AppDelegate! = nil
    var navigationController: UINavigationController! = nil
    var mainAlarmViewController: MainAlarmViewController! = nil

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let tuple = constructTestingViews(navDelegate: self)
        storyboard = tuple.0
        appDelegate = tuple.1
        navigationController = tuple.2
        mainAlarmViewController = tuple.3
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testStartupConfiguration() {
        let viewControllers = navigationController.viewControllers
        XCTAssert(viewControllers.first as? MainAlarmViewController == mainAlarmViewController)
        
        let navigationItemTitle = mainAlarmViewController.navigationItem.title
        XCTAssert(navigationItemTitle == "Alarm")
        
        XCTAssertNil(mainAlarmViewController.navigationItem.leftBarButtonItem)
        let rightButton = mainAlarmViewController.navigationItem.rightBarButtonItem
        XCTAssertNotNil(rightButton)
        XCTAssert(rightButton?.target?.identifier == "addSegue")
    }

}
