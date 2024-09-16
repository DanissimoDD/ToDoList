//
//  MainScreenPresenterTests.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 15.09.2024.
//

import XCTest
@testable import ToDoList

final class MainScreenPresenterTests: XCTestCase {
	
	var view: MainScreenViewControllerMock!
	var presenter: MainScreenPresenter!
	var router: MainScreenRouterMock!
	var interactor: MainScreenInteractorMock!

    override func setUp() {
		super.setUp()
		router = MainScreenRouterMock()
		interactor = MainScreenInteractorMock()
		presenter = MainScreenPresenter(
			output: interactor,
			router: router,
			defaults: Storage()
		)
		view = MainScreenViewControllerMock()
		presenter.view = view
    }

    override func tearDown() {
		view = nil
		presenter = nil
		router = nil
		interactor = nil
		super.tearDown()
    }
	
	func testViewDidLoad() {
		presenter.viewDidLoad()
		XCTAssertTrue(view.calls.contains(.updateDataSource))
		XCTAssertTrue(interactor.calls.contains(.fetchTasks))
	}

	func testShowTask() {
		presenter.viewDidLoad()
		presenter.showTask(index: 1)
		XCTAssertTrue(router.calls.contains(.goToTaskScreen))
	}
	
	func testAnyCheckMarkTapped() {
		presenter.viewDidLoad()
		presenter.anyCheckMarkTapped(item: 1)
		XCTAssertTrue(view.calls.contains(.updateDataSource))
		XCTAssertTrue(interactor.calls.contains(.updateTask))
	}
	
	func testCreateNewTask() {
		presenter.createNewTask()
		XCTAssertTrue(router.calls.contains(.goToTaskScreen))
	}
	
	func testSaveChanges() {
		presenter.viewDidLoad()
		presenter.saveChanges(index: 2)
		XCTAssertTrue(interactor.calls.contains(.updateTask))
	}

}
