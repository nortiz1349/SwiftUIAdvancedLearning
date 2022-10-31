//
//  CustomShapesBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/10/31.
//

import SwiftUI

struct Triangle: Shape {
	
	func path(in rect: CGRect) -> Path {
		Path { path in
			path.move(to: CGPoint(x: rect.midX, y: rect.minY))
			path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
		}
	}
	
}

struct Diamond: Shape {
	
	func path(in rect: CGRect) -> Path {
		Path { path in
			let horizontalOffset: CGFloat = rect.width * 0.2
			path.move(to: CGPoint(x: rect.midX, y: rect.minY))
			path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
			path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
			path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
		}
	}
}

struct Trapezoid: Shape {
	
	func path(in rect: CGRect) -> Path {
		Path { path in
			let horizontalOffset: CGFloat = rect.width * 0.2
			path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
			path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
			path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
			
		}
	}
}

struct CustomShapesBootcamp: View {
    var body: some View {
		ZStack {
			
			Trapezoid()
//				.stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [10]))
//				.foregroundColor(.blue)
//				.trim(from: 0, to: 0.5)
				.frame(width: 300, height: 300)
			
		}
    }
}

struct CustomShapesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapesBootcamp()
    }
}
