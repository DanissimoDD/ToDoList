//
//  TaskScreenRouterMock.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 16.09.2024.
//

@testable import ToDoList

final class TaskScreenRouterMock {
	enum Call {
		case returnToMainScreen
	}
	
	private(set) var calls: [Call] = []
}

extension TaskScreenRouterMock: TaskScreenRouter {
	func returnToMainScreen() {
		calls.append(.returnToMainScreen)
	}
}
