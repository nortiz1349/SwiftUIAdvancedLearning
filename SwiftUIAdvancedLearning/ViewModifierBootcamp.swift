//
//  ViewModifierBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/10/30.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
	
	let backgroundColor: Color
	
	func body(content: Content) -> some View {
		content
			.font(.headline)
			.foregroundColor(.white)
			.frame(height: 55)
			.frame(maxWidth: .infinity)
			.background(backgroundColor)
			.cornerRadius(10)
			.shadow(radius: 10)
//			.padding() // 패딩은 view modifier 에서 넣지 않는 것이 좋다.
	}
}

extension View {
	
	func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
		modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
	}
	
}

struct ViewModifierBootcamp: View {
    var body: some View {
		VStack(spacing: 10.0) {
			Text("Hello World!")
				.withDefaultButtonFormatting(backgroundColor: .orange)
				
			Text("Hello Everyone!")
				.withDefaultButtonFormatting()
			
			Text("Hello Everyone!")
				.font(.title)
				.withDefaultButtonFormatting(backgroundColor: .red)
		}
		.padding()
    }
}

struct ViewModifierBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierBootcamp()
    }
}
