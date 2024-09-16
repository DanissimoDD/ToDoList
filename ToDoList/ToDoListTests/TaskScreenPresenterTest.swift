//
//  TaskScreenPresenterTest.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 16.09.2024.
//

import XCTest
@testable import ToDoList

final class TaskScreenPresenterTest: XCTestCase {
	
	var view: TaskScreenViewControllerMock!
	var presenter: TaskScreenPresenter!
	var router: TaskScreenRouterMock!
	var interactor: TaskScreenInteractorMock!

	override func setUp() {
		super.setUp()
		router = TaskScreenRouterMock()
		interactor = TaskScreenInteractorMock()
		presenter = TaskScreenPresenter(
			router: router,
			output: interactor,
			model: MainScreenItemModel(
				title: "title",
				subTitle: "subtitle",
				dateTime: Date(), 
				hasDone: true
			)
		)
		view = TaskScreenViewControllerMock()
		presenter.view = view
	}

	override func tearDown() {
		view = nil
		presenter = nil
		router = nil
		interactor = nil
		super.tearDown()
	}
	
	func testIsEditMode(){
		XCTAssertTrue(presenter.isEditMode())
	}
	
	func testTaskDeletion() {
		presenter.taskDeletion()
		XCTAssertTrue(interactor.calls.contains(.deleteTask))
		XCTAssertTrue(router.calls.contains(.returnToMainScreen))
	}
	
	func testFinishTaskCreation() {
		presenter.finishTaskCreation(
			newModel: TaskScreenModel(
				title: "title",
				subTitle: "subtitle",
				dateTime: Date()
			)
		)
		XCTAssertTrue(interactor.calls.contains(.updateTask))
		XCTAssertTrue(router.calls.contains(.returnToMainScreen))
	}
	
	func testViewDidLoad() {
		presenter.viewDidLoad()
		XCTAssertTrue(view.calls.contains(.setData))
	}
}
