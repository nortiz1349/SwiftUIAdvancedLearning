//
//  AnimateableDataBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/10/31.
//

import SwiftUI

struct AnimateableDataBootcamp: View {
	
	@State private var animate: Bool = false
	
    var body: some View {
		ZStack {
//			RoundedRectangle(cornerRadius: animate ? 60 : 0)
//			RectangleWithSingleCornerAnimation(cornetRadius: animate ? 60 : 0)
//			Pacman(offsetAmount: animate ? 20 : 0)
			RectangleWithCustomCorner(corners: .topRight, cornerRadius: animate ? 60 : 20)
				.frame(width: 250, height: 250)
		}
		.onAppear {
			withAnimation(.easeInOut.repeatForever()) {
				animate.toggle()
			}
		}
    }
}

struct AnimateableDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnimateableDataBootcamp()
    }
}

struct RectangleWithSingleCornerAnimation: Shape {
	
	var cornetRadius: CGFloat
	
	/// Path 내부의 데이터를 수정하기 위해는 별도의 get, set 설정이 필요하다.
	var animatableData: CGFloat {
		get { cornetRadius }
		set { cornetRadius = newValue }
	}
	
	func path(in rect: CGRect) -> Path {
		Path { path in
			path.move(to: .zero)
			path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
			path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornetRadius))
			
			path.addArc(
				center: CGPoint(x: rect.maxX - cornetRadius, y: rect.maxY - cornetRadius),
				radius: cornetRadius,
				startAngle: Angle(degrees: 0),
				endAngle: Angle(degrees: 360),
				clockwise: false)
			
			path.addLine(to: CGPoint(x: rect.maxX - cornetRadius, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
		}
	}
}

struct Pacman: Shape {
	
	var offsetAmount: CGFloat
	
	var animatableData: CGFloat {
		get { offsetAmount }
		set { offsetAmount = newValue }
	}
	
	func path(in rect: CGRect) -> Path {
		Path { path in
			path.move(to: CGPoint(x: rect.midX, y: rect.minY))
			path.addArc(
				center: CGPoint(x: rect.midX, y: rect.minY),
				radius: rect.height / 2,
				startAngle: Angle(degrees: offsetAmount),
				endAngle: Angle(degrees: 360 - offsetAmount),
				clockwise: false)
		}
	}
}

struct RectangleWithCustomCorner: Shape {
	var corners: UIRectCorner
	var cornerRadius: CGFloat
	var animatableData: CGFloat{
		get{ cornerRadius }
		set { cornerRadius = newValue }
	}
	
	func path(in rect: CGRect) -> Path {
		let path = UIBezierPath(
			roundedRect: rect,
			byRoundingCorners: corners,
			cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
		return Path(path.cgPath)
	}
}
