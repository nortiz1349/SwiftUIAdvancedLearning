//
//  ScrollViewOffsetPreferenceKeyBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/10/31.
//

import SwiftUI

struct ScrollViewPreferenceKey: PreferenceKey {
	static var defaultValue: CGFloat = 0
	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		value = nextValue()
	}
}

extension View {
	func onScrollViewOffsetChanged(action: @escaping (_ offset: CGFloat) -> ()) -> some View {
		self
			.background {
				GeometryReader { geo in
					Text("")
						.preference(key: ScrollViewPreferenceKey.self, value: geo.frame(in: .global).minY)
				}
			}
			.onPreferenceChange(ScrollViewPreferenceKey.self) { value in
				action(value)
			}
	}
}

struct ScrollViewOffsetPreferenceKeyBootcamp: View {
	
	let title: String = "New title here!!"
	@State private var scrollViewOffset: CGFloat = 0
	
    var body: some View {
		ScrollView {
			VStack {
				titleLayer
					.opacity(scrollViewOffset / 75)
					.onScrollViewOffsetChanged { offset in
						scrollViewOffset = offset
					}
				contentLayer
			}
			.padding()
		}
		.overlay(content: {
			Text("\(scrollViewOffset)")
		})
		.overlay(alignment: .top) {
			navBarLayer
				.opacity(scrollViewOffset < 20 ? 1.0 : 0)
		}
    }
}

struct ScrollViewOffsetPreferenceKeyBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffsetPreferenceKeyBootcamp()
    }
}

extension ScrollViewOffsetPreferenceKeyBootcamp {
	
	private var titleLayer: some View {
		Text(title)
			.font(.largeTitle)
			.fontWeight(.semibold)
			.frame(maxWidth: .infinity, alignment: .leading)
	}
	
	private var contentLayer: some View {
		ForEach(0..<30) { _ in
			RoundedRectangle(cornerRadius: 10)
				.fill(.red.opacity(0.3))
				.frame(width: 300, height: 200)
		}
	}
	
	private var navBarLayer: some View {
		Text(title)
			.font(.headline)
			.frame(maxWidth: .infinity)
			.frame(height: 55)
			.background(.blue)
	}
}
