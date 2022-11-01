//
//  CustomNavLink.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/11/01.
//

import SwiftUI

struct CustomNavLink<Label:View, Destination: View>: View {
	
	let destination: Destination
	let label: Label
	
	init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
		self.destination = destination()
		self.label = label()
	}
	
    var body: some View {
		NavigationLink {
			CustomNavBarContainerView {
				destination
			}
			.toolbar(.hidden)
		} label: {
			label
		}

    }
}

struct CustomNavLink_Previews: PreviewProvider {
    static var previews: some View {
		CustomNavView {
			CustomNavLink {
				Text("Destination")
			} label: {
				Text("Navigate")
			}
		}
    }
}
