//
//  TestScreenViewControllerMock.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 16.09.2024.
//

@testable import ToDoList
import Foundation

final class TaskScreenViewControllerMock {
	
	enum Call {
		case setData
	}
	
	private(set) var calls: [Call] = []
}

extension TaskScreenViewControllerMock: TaskScreenViewInput {
	func setData(model: ToDoList.MainScreenItemModel) {
		calls.append(.setData)
	}
}
