//
//  MainScreenInteractorTests.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 15.09.2024.
//

import XCTest
@testable import ToDoList

final class MainScreenInteractorTests: XCTestCase {

	var interactor: MainScreenInteractor!
	var dataManager: DataManagerMock!
	var networkManager: NetworkManagerMock!
	var mapper: ResponseModelMapperMock!

	override func setUp() {
		super.setUp()
		dataManager = DataManagerMock()
		networkManager = NetworkManagerMock()
		mapper = ResponseModelMapperMock()
		interactor = MainScreenInteractor(
			dataManager: dataManager,
			networkManager: networkManager,
			mapper: mapper
		)
	}


	override func tearDown() {
        interactor = nil
		dataManager = nil
		networkManager = nil
		mapper = nil
		super.tearDown()
    }

	func testCreateNewTaskMO() {
		interactor.createNewTaskMO(model: MainScreenItemModel(title: "", subTitle: "", dateTime: Date(), hasDone: true))
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
			guard let self else { return }
			XCTAssertTrue(self.dataManager.calls.contains(.createTaskItem))
		}
	}
	
	func testFetchTasks() {
		let models = interactor.fetchTasks()
		XCTAssertTrue(self.dataManager.calls.contains(.fetchAllTasks))
	}
	
	func testUpdateTask() {
		interactor.updateTask(model: MainScreenItemModel(title: "", subTitle: "", dateTime: Date(), hasDone: true))
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
			guard let self else { return }
			XCTAssertTrue(self.dataManager.calls.contains(.updateTaskItem))
		}
	}
	
	func testFetchData() {
		interactor.fetchData {_ in }
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
			guard let self else { return }
			XCTAssertEqual(self.dataManager.calls.count, 3)
			XCTAssertTrue(self.dataManager.calls.contains(.createTaskItem))
		}
	}

}
