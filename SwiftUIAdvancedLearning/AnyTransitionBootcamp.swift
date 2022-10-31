//
//  AnyTransitionBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/10/31.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
	
	let rotationDegrees: Double
	
	func body(content: Content) -> some View {
		content
			.rotationEffect(Angle(degrees: rotationDegrees))
			.offset(
				x: rotationDegrees != 0 ? UIScreen.main.bounds.width : 0,
				y: rotationDegrees != 0 ? UIScreen.main.bounds.height : 0)
	}
	
}

extension AnyTransition {
	
	static var rotating: AnyTransition {
		modifier(
			active: RotateViewModifier(rotationDegrees: 180),
			identity: RotateViewModifier(rotationDegrees: 0))
	}
	
	static func rotating(rotation: Double) -> AnyTransition {
		modifier(
			active: RotateViewModifier(rotationDegrees: rotation),
			identity: RotateViewModifier(rotationDegrees: 0))
	}
	
	static var rotateOn: AnyTransition {
		asymmetric(
			insertion: .rotating,
			removal: .move(edge: .leading))
	}
}


struct AnyTransitionBootcamp: View {
	
	@State private var showRectangle: Bool = false
	
    var body: some View {
		VStack {
			Spacer()
			
			if showRectangle {
				RoundedRectangle(cornerRadius: 25)
					.frame(width: 250, height: 350)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.transition(.rotateOn)
			}
			
			Spacer()
			Text("Click Me!")
				.withDefaultButtonFormatting()
				.padding(.horizontal, 40)
				.onTapGesture {
					withAnimation(.easeInOut) {
						showRectangle.toggle()
					}
				}
		}
    }
}

struct AnyTransitionBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnyTransitionBootcamp()
    }
}
