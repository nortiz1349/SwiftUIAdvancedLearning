//
//  DependencyInjectionBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/11/02.
//

import SwiftUI
import Combine

// PROBLEMS WITH SINGLETONS
// 1. Singletons are GLOBAL
// 2. Can't customize the init!
// 3. Can't swap out dependencies

struct PostsModel: Identifiable, Codable, Hashable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
}

protocol DataServiceProtocol {
	func getData() -> AnyPublisher<[PostsModel], Error>
}

class ProductionDataService: DataServiceProtocol {

	let url: URL
	
	init(url: URL) {
		self.url = url
	}
	
	func getData() -> AnyPublisher<[PostsModel], Error> {
		URLSession.shared.dataTaskPublisher(for: url)
			.map({ $0.data })
			.decode(type: [PostsModel].self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
	
}

class MockDataService: DataServiceProtocol {
	
	let testData: [PostsModel]
	
	init(data: [PostsModel]?) {
		self.testData = data ?? [
			PostsModel(userId: 1, id: 1, title: "one", body: "one"),
			PostsModel(userId: 2, id: 2, title: "two", body: "two")
		]
	}
	
	func getData() -> AnyPublisher<[PostsModel], Error> {
		Just(testData)
			.tryMap({ $0 })
			.eraseToAnyPublisher()
	}
	
}



class DependencyInjectionViewModel: ObservableObject {
	
	@Published var dataArray: [PostsModel] = []
	private var cancellables = Set<AnyCancellable>()
	let dataService: DataServiceProtocol
	
	/// init에서 ProductionDataService를 Injection 받는다.
	init(dataService: DataServiceProtocol) {
		self.dataService = dataService
		loadPosts()
	}
	
	private func loadPosts() {
		dataService.getData()
			.sink { _ in
				
			} receiveValue: { [weak self] returnedPosts in
				self?.dataArray = returnedPosts
			}
			.store(in: &cancellables)
	}
}

struct DependencyInjectionBootcamp: View {
	
	@StateObject private var vm: DependencyInjectionViewModel
	
	init(dataService: DataServiceProtocol) {
		_vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
	}
	
    var body: some View {
//		ScrollView {
			List {
				ForEach(vm.dataArray, id: \.self) { post in
					Text(post.title)
				}
			}
//		}
    }
}

struct DependencyInjectionBootcamp_Previews: PreviewProvider {
	
//	static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
	
	static let dataService = MockDataService(data: [
		PostsModel(userId: 3, id: 3, title: "three", body: "three")
	])
	
    static var previews: some View {
		DependencyInjectionBootcamp(dataService: dataService)
    }
}
