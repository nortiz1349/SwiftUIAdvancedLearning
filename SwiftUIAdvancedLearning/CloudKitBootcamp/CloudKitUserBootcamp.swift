//
//  CloudKitUserBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Nortiz M1 on 2022/11/07.
//

import SwiftUI
import CloudKit

class CloudKitUserBootcampViewModel: ObservableObject {
	
	@Published var permissionStatus: Bool = false
	@Published var isSignedInToiCloud: Bool = false
	@Published var error: String = ""
	@Published var userName: String = ""
	
	init() {
		getiCloudStatus()
		requestPermission()
		fetchiCloudUserRecordID()
	}
	
	private func getiCloudStatus() {
		CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
			DispatchQueue.main.async {
				switch returnedStatus {
				case .available:
					self?.isSignedInToiCloud = true
				case .couldNotDetermine:
					self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
				case .restricted:
					self?.error = CloudKitError.iCloudAccountRestricted.rawValue
				case .noAccount:
					self?.error = CloudKitError.iCloudAccountNotFound.rawValue
				case .temporarilyUnavailable:
					self?.error = CloudKitError.iCloudAccountUnavailable.rawValue
				@unknown default:
					self?.error = CloudKitError.iCloudAccountUnknown.rawValue
				}
			}
		}
	}
	
	enum CloudKitError: String, LocalizedError {
		case iCloudAccountNotFound
		case iCloudAccountNotDetermined
		case iCloudAccountRestricted
		case iCloudAccountUnknown
		case iCloudAccountUnavailable
	}
	
	func requestPermission() {
		CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
			DispatchQueue.main.async {
				if returnedStatus == .granted {
					self?.permissionStatus = true
				}
			}
		}
	}
	
	
	func fetchiCloudUserRecordID() {
		CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnError in
			if let id = returnedID {
				self?.discoveriCloudUser(id: id)
			}
		}
	}
	
	func discoveriCloudUser(id: CKRecord.ID) {
		CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
			DispatchQueue.main.async {
				if let name = returnedIdentity?.nameComponents?.givenName {
					self?.userName = name
				}
			}
		}
	}
	
	
}

struct CloudKitUserBootcamp: View {
	
	@StateObject private var vm = CloudKitUserBootcampViewModel()
	
    var body: some View {
		VStack {
			Text("IS SIGNED IN: \(vm.isSignedInToiCloud.description.uppercased())")
			Text(vm.error)
			Text("Permission: \(vm.permissionStatus.description)")
			Text("NAME: \(vm.userName)")
		}
		
    }
}

struct CloudKitUserBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitUserBootcamp()
    }
}
