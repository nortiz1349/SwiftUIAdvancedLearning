//
//  GenericsBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/10/31.
//

import SwiftUI

struct StringModel {
	let info: String?
	func removeInfo() -> StringModel {
		StringModel(info: nil)
	}
}
struct BoolModel {
	let info: Bool?
	func removeInfo() -> BoolModel {
		BoolModel(info: nil)
	}
}
struct GenericModel<T> {
	let info: T?
	func removeInfo() -> GenericModel {
		GenericModel(info: nil)
	}
}

class GenericsViewModel: ObservableObject {
	
	@Published var stringModel = StringModel(info: "Hello, world.")
	@Published var boolModel = BoolModel(info: true)
	
	@Published var genericStringModel = GenericModel(info: "Hello, world!")
	@Published var genericBoolModel = GenericModel(info: true)
	
	func removeData() {
		stringModel = stringModel.removeInfo()
		boolModel = boolModel.removeInfo()
		genericStringModel = genericStringModel.removeInfo()
		genericBoolModel = genericBoolModel.removeInfo()
	}
	
}

struct GenericView<T: View>: View {
	
	let content: T
	let title: String
	
	var body: some View {
		VStack {
			Text(title)
			content
		}
		
	}
}

struct GenericsBootcamp: View {
	
	@StateObject private var vm = GenericsViewModel()
	
    var body: some View {
		VStack {
			GenericView(content: Text("custom content"), title: "new view!!")
//			GenericView(title: "new view!")
			
			Text(vm.stringModel.info ?? "No data")
			Text(vm.boolModel.info?.description ?? "No data")
			Text(vm.genericStringModel.info ?? "No data")
			Text(vm.genericBoolModel.info?.description ?? "No data")
		}
		.onTapGesture {
			vm.removeData()
		}
    }
}

struct GenericsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GenericsBootcamp()
    }
}
