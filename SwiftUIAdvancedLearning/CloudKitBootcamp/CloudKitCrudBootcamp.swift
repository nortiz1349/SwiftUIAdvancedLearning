//
//  CloudKitCrudBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/11/07.
//

import SwiftUI
import CloudKit

struct FruitModel: Hashable {
	let name: String
	let imageURL: URL?
	let record: CKRecord
}

class CloudKitCrudBootcampViewModel: ObservableObject {
	
	@Published var text: String = ""
	@Published var fruits: [FruitModel] = []
	
	init() {
		fetchItems()
	}
	
	func addButtonPressed() {
		guard !text.isEmpty else { return }
		addItem(name: text)
	}
	
	private func addItem(name: String) {
		let newFruit = CKRecord(recordType: "Fruits")
		newFruit["name"] = name
		
		guard
			let image = UIImage(named: "coingecko"),
			let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("coingecko", conformingTo: .png),
			let data = image.pngData() else { return }
		
		do {
			try data.write(to: url)
			let asset = CKAsset(fileURL: url)
			newFruit["image"] = asset
			saveItem(record: newFruit)
		} catch let error {
			print(error)
		}
	}
	
	private func saveItem(record: CKRecord) {
		CKContainer.default().publicCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
			print("Record: \(returnedRecord)")
			print("Error: \(returnedError)")
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
				self?.text = ""
				self?.fetchItems()
			}
		}
	}
	
	func fetchItems() {
		
		let predicate = NSPredicate(value: true)
//		let predicate = NSPredicate(format: "name = %@", argumentArray: ["Peach"])
		let query = CKQuery(recordType: "Fruits", predicate: predicate)
		query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
		let queryOperation = CKQueryOperation(query: query)
//		queryOperation.resultsLimit = 2 // 맥시멈 쿼리가 100개로 제한된다.
		
		var returnedItems: [FruitModel] = []
		
		queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
			switch returnedResult {
			case .success(let record):
				guard let name = record["name"] as? String else { return }
				let imageAsset = record["image"] as? CKAsset
				let imageURL = imageAsset?.fileURL
				print(record)
				returnedItems.append(FruitModel(name: name, imageURL: imageURL, record: record))
			case .failure(let error):
				print("Error RecordMatchedBlock: \(error)")
			}
		}
		
		queryOperation.queryResultBlock = { [weak self] returnedResult in
			print("RETURNED RESULT: \(returnedResult)")
			DispatchQueue.main.async {
				self?.fruits = returnedItems
			}
		}
		addOperation(operation: queryOperation)
	}
	
	func addOperation(operation: CKDatabaseOperation) {
		CKContainer.default().publicCloudDatabase.add(operation)
	}
	
	func updateItem(fruit: FruitModel) {
		let record = fruit.record
		record["name"] = "NEW NAME!!"
		saveItem(record: record)
	}
	
	func delteItem(indexSet: IndexSet) {
		guard let index = indexSet.first else { return }
		let fruit = fruits[index]
		let record = fruit.record
		
		CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { [weak self] returnedRecordID, returnedError in
			DispatchQueue.main.async {
				self?.fruits.remove(at: index)
			}
		}
	}
}

struct CloudKitCrudBootcamp: View {
	
	@StateObject private var vm = CloudKitCrudBootcampViewModel()
	
    var body: some View {
		NavigationView {
			VStack {
				header
				textField
				addButton
				
				List {
					ForEach(vm.fruits, id: \.self) { fruit in
						HStack {
							Text(fruit.name)
							
							if let url = fruit.imageURL, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
								Image(uiImage: image)
									.resizable()
									.frame(width: 50, height: 50)
							}
						}
						.onTapGesture {
							vm.updateItem(fruit: fruit)
						}
					}
					.onDelete(perform: vm.delteItem)
				}
				.listStyle(.plain)
			}
			.padding()
			.toolbar(.hidden)
		}
    }
}

struct CloudKitCrudBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitCrudBootcamp()
    }
}

extension CloudKitCrudBootcamp {
	
	private var header: some View {
		Text("CloudKit CRUD ☁️☁️☁️")
			.font(.headline)
			.underline()
	}
	
	private var textField: some View {
		TextField("Add something here...", text: $vm.text)
			.frame(height: 55)
			.padding(.leading)
			.background(Color.gray.opacity(0.4))
			.cornerRadius(10)
	}
	
	private var addButton: some View {
		Button {
			vm.addButtonPressed()
		} label: {
			Text("Add")
				.foregroundColor(.white)
				.frame(height: 55)
				.frame(maxWidth: .infinity)
				.background(Color.pink)
				.cornerRadius(10)
		}
	}
}
