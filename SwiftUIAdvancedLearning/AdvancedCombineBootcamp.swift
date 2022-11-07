//
//  AdvancedCombineBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/11/04.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
	
//	@Published var basicPublisher: String = "first publish"
//	let currentValuePublisher = CurrentValueSubject<Int, Error>("first publish")
	let passThroughPublisher = PassthroughSubject<Int, Error>()
	
	init() {
		publishFakeData()
	}
	
	private func publishFakeData() {
		let items: [Int] = Array(0..<11)
		
		for x in items.indices {
			DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
				self.passThroughPublisher.send(items[x])
			}
		
		}
	}
	
}

class AdvancedCombineBootcampViewModel: ObservableObject {
	
	@Published var data: [String] = []
	let dataService = AdvancedCombineDataService()
	var cancellables = Set<AnyCancellable>()
	
	init() {
		addSubscriber()
	}
	
	private func addSubscriber() {
		dataService.passThroughPublisher
			.map({ String($0) })
			.sink { completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					print("ERROR: \(error.localizedDescription)")
				}
			} receiveValue: { [weak self] returnedValue in
				self?.data.append(returnedValue)
			}
			.store(in: &cancellables)

	}
}

struct AdvancedCombineBootcamp: View {
	
	@StateObject private var vm = AdvancedCombineBootcampViewModel()
	
    var body: some View {
		ScrollView {
			VStack {
				ForEach(vm.data, id: \.self) {
					Text($0)
						.font(.largeTitle)
						.fontWeight(.black)
				}
			}
		}
    }
}

struct AdvancedCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCombineBootcamp()
    }
}
