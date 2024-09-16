//
//  TaskScreenPresenterOutputMock.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 16.09.2024.
//

@testable import ToDoList

final class TaskScreenPresenterOutputMock {
	
	enum Call {
		case viewDidLoad
		case finishTaskCreation
		case taskDeletion
		case isEditMode
	}
	
	private(set) var calls: [Call] = []
}

extension TaskScreenPresenterOutputMock: TaskScreenViewOutput {
	func viewDidLoad() {
		calls.append(.viewDidLoad)
	}
	
	func finishTaskCreation(newModel: ToDoList.TaskScreenModel) {
		calls.append(.finishTaskCreation)
	}
	
	func taskDeletion() {
		calls.append(.taskDeletion)
	}
	
	func isEditMode() -> Bool {
		calls.append(.isEditMode)
		return true
	}
}
