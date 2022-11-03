//
//  UnitTestingBootcampView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/11/02.
//

/*
 1. Unit Tests
 - test the business logic in app
 
 2. UI Tests
 - test the UI of app
 
 */

import SwiftUI

struct UnitTestingBootcampView: View {
	
	@StateObject private var vm: UnitTestingBootcampViewModel
	
	init(isPremium: Bool) {
		_vm = StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))
	}
	
    var body: some View {
		Text(vm.isPremium.description)
    }
}

struct UnitTestingBootcampView_Previews: PreviewProvider {
    static var previews: some View {
		UnitTestingBootcampView(isPremium: true)
    }
}
