//
//  PreferenceKeyBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/10/31.
//

import SwiftUI

struct PreferenceKeyBootcamp: View {
	
	@State private var text: String = "Hello, world"
	
    var body: some View {
		NavigationStack {
			VStack {
				SecondaryScreen(text: text)
					.navigationTitle("Navigation Title")
			}
		}
		.onPreferenceChange(CustomTitlePreferenceKey.self) { value in
			self.text = value
		}
    }
}

extension View {
	
	func customTitle(_ text: String) -> some View {
		preference(key: CustomTitlePreferenceKey.self, value: text)
	}
}

struct PreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceKeyBootcamp()
    }
}

struct SecondaryScreen: View {
	
	let text: String
	@State private var newValue: String = ""
	
	var body: some View {
		Text(text)
			.onAppear {
				getDataFromDatabase()
			}
			.customTitle(newValue)
	}
	
	func getDataFromDatabase() {
		// download
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			self.newValue = "NEW VALUE FROM DATABASE"
		}
	}
	
}

struct CustomTitlePreferenceKey: PreferenceKey {
	
	static var defaultValue: String = ""
	
	static func reduce(value: inout String, nextValue: () -> String) {
		value = nextValue()
	}
}
