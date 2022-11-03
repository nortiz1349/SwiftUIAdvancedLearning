//
//  NewMockDataService_Tests.swift
//  SwiftUIAdvancedLearning_Tests
//
//  Created by Nortiz M1 on 2022/11/03.
//

import XCTest
@testable import SwiftUIAdvancedLearning
import Combine

final class NewMockDataService_Tests: XCTestCase {

	var cancellables = Set<AnyCancellable>()
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		cancellables.removeAll()
    }

	func test_newMockDataService_init_doesSetValuesCorrectly() {
		// Given
		let items: [String]? = nil
		let items2: [String]? = []
		let items3: [String]? = [UUID().uuidString, UUID().uuidString]
		
		// When
		let dataService = NewMockDataService(items: items)
		let dataService2 = NewMockDataService(items: items2)
		let dataService3 = NewMockDataService(items: items3)
		
		// Then
		XCTAssertFalse(dataService.items.isEmpty)
		XCTAssertTrue(dataService2.items.isEmpty)
		XCTAssertEqual(dataService3.items.count, items3?.count)
	}
	
	func test_newMockDataService_downloadWithEscaping_doesReturnItems() {
		// Given
		let dataService = NewMockDataService(items: nil)
		
		// When
		var items: [String] = []
		let expectaion = XCTestExpectation()
		
		dataService.downloadItemsWithEscaping { returnedItem in
			expectaion.fulfill()
			items = returnedItem
		}
		
		// Then
		wait(for: [expectaion], timeout: 5)
		XCTAssertEqual(dataService.items.count, items.count)
	}
	
	func test_newMockDataService_downloadWithCombine_doesReturnItems() {
		// Given
		let dataService = NewMockDataService(items: nil)
		
		// When
		var items: [String] = []
		let expectaion = XCTestExpectation()
		
		dataService.downloadItemsWithCombine()
			.sink { completion in
				switch completion {
				case .finished:
					expectaion.fulfill()
				case .failure:
					XCTFail()
				}
			} receiveValue: { returnedItems in
				items = returnedItems
			}
			.store(in: &cancellables)

		
		// Then
		wait(for: [expectaion], timeout: 5)
		XCTAssertEqual(dataService.items.count, items.count)
	}
    
	func test_newMockDataService_downloadWithCombine_doesFail() {
		// Given
		let dataService = NewMockDataService(items: [])
		
		// When
		var items: [String] = []
		let expectaion = XCTestExpectation(description: "Does throw an error")
		let expectaion2 = XCTestExpectation(description: "Does throw URLError.badSeverResponse")
		
		dataService.downloadItemsWithCombine()
			.sink { completion in
				switch completion {
				case .finished:
					XCTFail()
				case .failure(let error):
					expectaion.fulfill()
					
//					let urlError = error as? URLError
//					XCTAssertEqual(urlError, URLError(.badServerResponse))
					
					if error as? URLError == URLError(.badServerResponse) {
						expectaion2.fulfill()
					}
				}
			} receiveValue: { returnedItems in
				items = returnedItems
			}
			.store(in: &cancellables)
		
		
		// Then
		wait(for: [expectaion, expectaion2], timeout: 5)
		XCTAssertEqual(dataService.items.count, items.count)
	}
}
