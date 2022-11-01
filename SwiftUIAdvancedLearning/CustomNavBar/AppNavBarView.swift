//
//  AppNavBarView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/11/01.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
		CustomNavView {
			ZStack {
				Color.orange
					.ignoresSafeArea()
				
				CustomNavLink {
					Text("Destination")
						.customNavigationTitle("Second Screen")
						.customNavigationSubtitle("subtitle second")
				} label: {
					Text("Navigate")
				}
			}
			.customNavBarItems(title: "New Title", subtitle: "New subtitle!", backButtonHidden: true)
		}
    }
}

struct AppNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBarView()
    }
}

extension AppTabBarView {
	
	private var defaultNavBarView: some View {
		NavigationView {
			ZStack {
				Color.green.ignoresSafeArea()
				
				NavigationLink {
					Text("Destination")
						.navigationTitle("Title 2")
				} label: {
					Text("Navigate")
				}
			}
			.navigationTitle("Nav title")
		}
	}
}
