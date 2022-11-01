//
//  CustomNavBarView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/11/01.
//

import SwiftUI

struct CustomNavBarView: View {
	
	@Environment(\.dismiss) var dismiss
	let showBackButton: Bool
	let title: String
	let subtitle: String?
	
    var body: some View {
		HStack {
			if showBackButton {
				backButton
			}
			Spacer()
			titleSection
			Spacer()
			if showBackButton {
				backButton
					.opacity(0)
			}
		}
		.padding()
		.tint(.white)
		.foregroundColor(.white)
		.font(.headline)
		.background(.green)
    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			CustomNavBarView(showBackButton: true, title: "Title here", subtitle: "Subtitle here")
			Spacer()
		}
    }
}

extension CustomNavBarView {
	
	private var backButton: some View {
		Button {
			dismiss()
		} label: {
			Image(systemName: "chevron.left")
		}
	}
	
	private var titleSection: some View {
		VStack {
			Text(title)
				.font(.title)
				.fontWeight(.semibold)
			if let subtitle = subtitle {
				Text(subtitle)
			}
		}
	}
	
}
