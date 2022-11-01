//
//  CustomNavView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/11/01.
//

import SwiftUI

struct CustomNavView<Content: View>: View {
	
	let content: Content
	
	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}
	
    var body: some View {
		NavigationView {
			CustomNavBarContainerView {
				content
			}
			.toolbar(.hidden)
		}
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
		CustomNavView {
			Color.orange.ignoresSafeArea()
		}
    }
}

extension UINavigationController {
	open override func viewDidLoad() {
		super.viewDidLoad()
		interactivePopGestureRecognizer?.delegate = nil
	}
}
