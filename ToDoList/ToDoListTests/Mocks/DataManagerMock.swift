//
//  DataManagerMock.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 16.09.2024.
//

import Foundation
@testable import ToDoList

final class DataManagerMock {
	
	enum Call {
	case createTaskItem
	case fetchAllTasks
	case updateTaskItem
	case deleteTaskItem
	}
	
	private(set) var calls: [Call] = []
}

extension DataManagerMock: DataStore {
	func createTaskItem(_ model: ToDoList.MainScreenItemModel) {
		calls.append(.createTaskItem)
	}
	
	func fetchAllTasks() -> [ToDoList.MainScreenItemModel] {
		calls.append(.fetchAllTasks)
		return [
			ToDoList.MainScreenItemModel(model: TaskScreenModel(
			title: "Task 1",
			subTitle: "Discription 1",
			dateTime: Date())),
			ToDoList.MainScreenItemModel(model: TaskScreenModel(
			title: "Task 2",
			subTitle: "Discription 2",
			dateTime: Date())),
			ToDoList.MainScreenItemModel(model: TaskScreenModel(
			title: "Task 3",
			subTitle: "Discription 3",
			dateTime: Date())),
		]
	}
	
	func updateTaskItem(model: ToDoList.MainScreenItemModel) {
		calls.append(.updateTaskItem)
	}
	
	func deleteTaskItem(modelId: UUID) {
		calls.append(.deleteTaskItem)
	}
	
	
}
