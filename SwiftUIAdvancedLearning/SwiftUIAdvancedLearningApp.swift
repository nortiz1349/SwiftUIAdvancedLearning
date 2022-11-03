//
//  SwiftUIAdvancedLearningApp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/10/30.
//

import SwiftUI

@main
struct SwiftUIAdvancedLearningApp: App {
	
	let currentUserIsSignedIn: Bool
	
	init() {
//		let userIsSignedIn: Bool = CommandLine.arguments.contains("-UITest_startSignedIn") ? true : false
		let userIsSignedIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITest_startSignedIn")
//		let value = ProcessInfo.processInfo.environment["-UITest_startSignedIn2"]
//		let userIsSignedIn: Bool = value == "true"
		self.currentUserIsSignedIn = userIsSignedIn
	}
	
    var body: some Scene {
        WindowGroup {
			UITestingBootcampView(currentUserIsSignedIn: currentUserIsSignedIn)
        }
    }
}
