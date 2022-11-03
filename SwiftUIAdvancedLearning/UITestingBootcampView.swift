//
//  UITestingBootcampView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/11/03.
//

import SwiftUI

class UITestingBootcampViewModel: ObservableObject {
	
	let placeHolderText: String = "Add name here..."
	@Published var textFieldText: String = ""
	@Published var currentUserIsSignedIn: Bool
	
	init(currentUserIsSignedIn: Bool) {
		self.currentUserIsSignedIn = currentUserIsSignedIn
	}
	
	func signUpButtonPressed() {
		guard !textFieldText.isEmpty else { return }
		currentUserIsSignedIn = true
	}
}

struct UITestingBootcampView: View {
	
	@StateObject private var vm: UITestingBootcampViewModel
	
	init(currentUserIsSignedIn: Bool) {
		_vm = StateObject(wrappedValue: UITestingBootcampViewModel(currentUserIsSignedIn: currentUserIsSignedIn))
	}
	
    var body: some View {
		ZStack {
			LinearGradient(
				colors: [Color.blue, Color.black],
				startPoint: .topLeading,
				endPoint: .bottomTrailing)
			.ignoresSafeArea()
			
			ZStack {
				if vm.currentUserIsSignedIn {
					SignedInHomeView()
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.transition(.move(edge: .trailing))
				}
				if !vm.currentUserIsSignedIn {
					signUpLayer
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.transition(.move(edge: .leading))
				}
			}
		}
    }
}

struct UITestingBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        UITestingBootcampView(currentUserIsSignedIn: true)
    }
}

extension UITestingBootcampView {
	
	private var signUpLayer: some View {
		VStack {
			TextField(vm.placeHolderText, text: $vm.textFieldText)
				.font(.headline)
				.padding()
				.background(.white)
				.cornerRadius(10)
				.accessibilityIdentifier("SignUpTextField")
			
			Button {
				withAnimation(.spring()) {
					vm.signUpButtonPressed()
				}
			} label: {
				Text("Sign up")
					.font(.headline)
					.foregroundColor(.white)
					.padding()
					.frame(maxWidth: .infinity)
					.background(.blue)
					.cornerRadius(10)
			}
			.accessibilityIdentifier("SignUpButton")
		}
		.padding()
	}
}

struct SignedInHomeView: View {
	
	@State private var showAlert: Bool = false
	
	var body: some View {
		NavigationView {
			VStack(spacing: 20) {
				
				Button {
					showAlert.toggle()
				} label: {
					Text("Show wecome alert!")
						.font(.headline)
						.foregroundColor(.white)
						.padding()
						.frame(maxWidth: .infinity)
						.background(.red)
						.cornerRadius(10)
				}
				.accessibilityIdentifier("showAlertButton")
				.alert(isPresented: $showAlert) {
					Alert(title: Text("welcome to the app"))
				}
				
				NavigationLink {
					Text("Destination")
				} label: {
					Text("Navigate")
						.font(.headline)
						.foregroundColor(.white)
						.padding()
						.frame(maxWidth: .infinity)
						.background(.blue)
						.cornerRadius(10)
				}
				.accessibilityIdentifier("NavigationLinkToDestination")
			}
			.padding()
			.navigationTitle("Welcome")
		}
	}
}
