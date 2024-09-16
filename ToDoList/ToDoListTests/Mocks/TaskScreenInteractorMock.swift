//
//  TaskScreenInteractorMock.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 16.09.2024.
//

import Foundation
@testable import ToDoList

final class  TaskScreenInteractorMock {
	enum Call {
		case createNewTaskMO
		case updateTask
		case deleteTask
	}
	
	private(set) var calls: [Call] = []
}

extension TaskScreenInteractorMock: TaskScreenPresenterOutput {
	func createNewTaskMO(model: ToDoList.MainScreenItemModel) {
		calls.append(.createNewTaskMO)
	}
	
	func updateTask(model: ToDoList.MainScreenItemModel) {
		calls.append(.updateTask)
	}
	
	func deleteTask(modelId: UUID) {
		calls.append(.deleteTask)
	}
}
