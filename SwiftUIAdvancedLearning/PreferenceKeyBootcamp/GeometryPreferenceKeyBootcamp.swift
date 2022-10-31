//
//  GeometryPreferenceKeyBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/10/31.
//

import SwiftUI

struct GeometryPreferenceKeyBootcamp: View {
	
	@State private var rectSize: CGSize = .zero // 4. 자식 View에서 보낸 값을 받을 프로퍼티 생성
	
    var body: some View {
		ZStack {
			VStack {
				Text("Hello")
					.frame(width: rectSize.width, height: rectSize.height)
					.background(.blue)
				Spacer()
				HStack {
					Rectangle()
					GeometryReader { geo in
						Rectangle()
							.updateRectangleGeoSize(geo.size) // 3. 부모 View로 보낼 값 지정
					}
					Rectangle()
				}
				.frame(height: 55)
			}
			.onPreferenceChange(RectangleGeometrySizePreferenceKey.self) { value in
				self.rectSize = value // 5. 자식 View에서 보낸 값을 프로퍼티로 전달
			}
		}
		.padding()
    }
}

struct GeometryPreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKeyBootcamp()
    }
}

/*
 2. View의 extension을 구현
 View를 반환하는 preference 함수를 생성
 */
extension View {
	func updateRectangleGeoSize(_ size: CGSize) -> some View {
		preference(key: RectangleGeometrySizePreferenceKey.self, value: size)
	}
}
/*
 1. PreferenceKey 프로토콜을 구현하는 struct 생성,
 defaultValue 타입을 parent view 로 보낼 값의 타입으로 설정하고 초기값 부여
 reduce 함수 구현
 */
struct RectangleGeometrySizePreferenceKey: PreferenceKey {
	
	static var defaultValue: CGSize = .zero
	
	static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
		value = nextValue()
	}
}
