//
//  UITestingBootcampView_Tests.swift
//  SwiftUIAdvancedLearning_UITests
//
//  Created by Nortiz M1 on 2022/11/03.
//

import XCTest

/*
 Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
 Naming Structure: test_[sturct]_[ui component]_[expected result]
 Testing Structure: Given, When, Then
 */

final class UITestingBootcampView_Tests: XCTestCase {
	
	let app = XCUIApplication()

    override func setUpWithError() throws {
		continueAfterFailure = false
//		app.launchArguments = ["-UITest_startSignedIn"]
//		app.launchEnvironment = ["-UITest_startSignedIn2" : "true"]
		app.launch()
    }

    override func tearDownWithError() throws {
    }

	func test_UITestingBootcampView_signInButton_shouldNotSignIn() {
		// Given
		signUpAndSignIn(shouldTypeOnKeyboard: false)
		
		// When
		let navBar = app.navigationBars["Welcome"]
		
		// Then
		XCTAssertFalse(navBar.exists)
	}
	
	func test_UITestingBootcampView_signInButton_shouldSignIn() {
		// Given
		signUpAndSignIn(shouldTypeOnKeyboard: true)
		
		// When
		let navBar = app.navigationBars["Welcome"]
		
		// Then
		XCTAssertTrue(navBar.exists)
	}
	
	func test_SignInHomeView_showAlertButton_shouldDisplayAlert() {
		// Given
		signUpAndSignIn(shouldTypeOnKeyboard: true)
		
		// When
		tapAlertButton(shouldDismissAlert: false)
		
		// Then
		let alert = app.alerts.firstMatch
		XCTAssertTrue(alert.exists)
	}
	
	func test_SignInHomeView_showAlertButton_shouldDisplayAndDismissAlert() {
		// Given
		signUpAndSignIn(shouldTypeOnKeyboard: true)
		
		// When
		tapAlertButton(shouldDismissAlert: true)

		// Then
		let alertExists = app.alerts.firstMatch.waitForExistence(timeout: 5)
		XCTAssertFalse(alertExists)
	}
	
	func test_SignInHomeView_navigationLinkToDestination_shouldNavigateToDestination() {
		
		// Given
		signUpAndSignIn(shouldTypeOnKeyboard: true)
		
		// When
		tapNavigationLink(shouldDismissDestination: false)
		
		// Then
		let destinationText = app.staticTexts["Destination"]
		XCTAssertTrue(destinationText.exists)
	}
	
	func test_SignInHomeView_navigationLinkToDestination_shouldNavigateToDestinationAndGoBack() {
		
		// Given
		signUpAndSignIn(shouldTypeOnKeyboard: true)
		
		// When
		tapNavigationLink(shouldDismissDestination: true)
		
		// Then
		let navBar = app.navigationBars["Welcome"]
		XCTAssertTrue(navBar.exists)
	}
	
//	func test_SignInHomeView_navigationLinkToDestination_shouldNavigateToDestinationAndGoBack2() {
//
//		// Given
//
//
//		// When
//		tapNavigationLink(shouldDismissDestination: true)
//
//		// Then
//		let navBar = app.navigationBars["Welcome"]
//		XCTAssertTrue(navBar.exists)
//	}
	
}

// MARK: - FUNCTIONS
extension UITestingBootcampView_Tests {
	
	func signUpAndSignIn(shouldTypeOnKeyboard: Bool) {
		let textField = app.textFields["SignUpTextField"]
		textField.tap()
		
		if shouldTypeOnKeyboard {
			let keyA = app.keys["A"]
			keyA.tap()
			let keya = app.keys["a"]
			keya.tap()
			keya.tap()
		}
		
		let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
		returnButton.tap()
		
		let signUpButton = app.buttons["SignUpButton"]
		signUpButton.tap()
	}
	
	func tapAlertButton(shouldDismissAlert: Bool) {
		let alertButton = app.buttons["showAlertButton"]
		alertButton.tap()
		
		if shouldDismissAlert {
			let alert = app.alerts.firstMatch
			let alertOKButton = alert.buttons["OK"]
			let alertOKButtonExists = alertOKButton.waitForExistence(timeout: 5)
			XCTAssertTrue(alertOKButtonExists)
			alertOKButton.tap()
		}
	}
	
	func tapNavigationLink(shouldDismissDestination: Bool) {
		
		let navLinkButton = app/*@START_MENU_TOKEN@*/.buttons["NavigationLinkToDestination"]/*[[".buttons[\"Navigate\"]",".buttons[\"NavigationLinkToDestination\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		navLinkButton.tap()
		
		if shouldDismissDestination {
			let backButton = app.navigationBars.buttons["Welcome"]
			backButton.tap()
		}
	}
	
}
