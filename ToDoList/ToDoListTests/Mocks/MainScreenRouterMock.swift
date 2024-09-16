//
//  MainScreenRouterMock.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 16.09.2024.
//

@testable import ToDoList

final class MainScreenRouterMock {
	enum Call {
		case goToTaskScreen
	}
	
	private(set) var calls: [Call] = []
}

extension MainScreenRouterMock: MainScreenRouter {
	func goToTaskScreen(model: ToDoList.MainScreenItemModel?) {
		calls.append(.goToTaskScreen)
	}
}
