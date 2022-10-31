//
//  ButtonStyleBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/10/31.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
	
	let scaledAmount: CGFloat
	
	// 디폴트값 정하기
	init(scaledAmount: CGFloat = 0.9) {
		self.scaledAmount = scaledAmount
	}
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
//			.brightness(configuration.isPressed ? 0.05 : 0)
			.opacity(configuration.isPressed ? 0.9 : 1.0)
	}
}

extension View {
	
	func withPressableStyle(scaledAmount: CGFloat) -> some View {
		self.buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
	}
}

struct ButtonStyleBootcamp: View {
    var body: some View {
		Button {
			
		} label: {
			Text("Click me!")
				.withDefaultButtonFormatting()
		}
//		.buttonStyle(PressableButtonStyle())
		.withPressableStyle(scaledAmount: 0.6)
		.padding()

    }
}

struct ButtonStyleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleBootcamp()
    }
}
