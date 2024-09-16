//
//  TaskScreenInteractorTest.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 16.09.2024.
//

import XCTest
@testable import ToDoList

final class TaskScreenInteractorTest: XCTestCase {

	var interactor: TaskScreenInteractor!
	
	var dataManager: DataManagerMock!
	
	
    override func setUp() {
		super.setUp()
		dataManager = DataManagerMock()
		interactor = TaskScreenInteractor(dataManager: dataManager)
    }

    override func tearDown() {
		dataManager = nil
		interactor = nil
		super.tearDown()
    }

	func testCreateNewTaskMO() {
		interactor.createNewTaskMO(
			model: MainScreenItemModel(
				title: "title",
				subTitle: "subtitle",
				dateTime: Date(),
				hasDone: true
			)
		)
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
			guard let self else { return }
			XCTAssertTrue(dataManager.calls.contains(.createTaskItem))
		}
	}
	
	func testUpdateTask() {
		interactor.updateTask(
			model: MainScreenItemModel(
				title: "title",
				subTitle: "subtitle",
				dateTime: Date(),
				hasDone: true
			)
		)
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
			guard let self else { return }
			XCTAssertTrue(dataManager.calls.contains(.updateTaskItem))
		}
	}
	
	func testDeleteTask() {
		interactor.deleteTask(modelId: UUID())
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
			guard let self else { return }
			XCTAssertTrue(dataManager.calls.contains(.updateTaskItem))
		}
	}

}
