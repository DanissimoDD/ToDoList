//
//  MainScreenPresenterMock.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 15.09.2024.
//

import Foundation
@testable import ToDoList

class MockMainScreenPresenter: MainScreenViewOutput {
	
	var viewDidLoadCalled = false
	
	func saveChanges(index: Int) {

	}
	
	func viewDidLoad() {
		viewDidLoadCalled = true
	}
	
	func createNewTask() {}
	
	func anyCheckMarkTapped(item: Int) {}
	
	func showTask(index: Int) {}
}
