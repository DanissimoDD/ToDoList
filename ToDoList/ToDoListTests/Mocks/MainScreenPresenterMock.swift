//
//  MainScreenPresenterMock.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 15.09.2024.
//

@testable import ToDoList

final class MainScreenPresenterOutputMock {
	
	enum Call {
		case saveChanges
		case viewDidLoad
		case createNewTask
		case anyCheckMarkTapped
		case showTask
	}
	
	private(set) var calls: [Call] = []
}

extension MainScreenPresenterOutputMock: MainScreenViewOutput {
	func saveChanges(index: Int) {
		calls.append(.saveChanges)
	}
	
	func viewDidLoad() {
		calls.append(.viewDidLoad)
	}
	
	func createNewTask() {
		calls.append(.createNewTask)
	}
	
	func anyCheckMarkTapped(item: Int) {
		calls.append(.anyCheckMarkTapped)
	}
	
	func showTask(index: Int) {
		calls.append(.showTask)
	}
}
