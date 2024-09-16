//
//  MockMainScreenInteractor.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 16.09.2024.
//

import Foundation
@testable import ToDoList

final class  MainScreenInteractorMock {
	enum Call {
		case fetchTasks
		case createNewTaskMO
		case updateTask
		case fetchData
	}
	
	private(set) var calls: [Call] = []
}

extension MainScreenInteractorMock: MainScreenPresenterOutput {
	func fetchTasks() -> [ToDoList.MainScreenItemModel] {
		calls.append(.fetchTasks)
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
	
	func createNewTaskMO(model: ToDoList.MainScreenItemModel) {
		calls.append(.createNewTaskMO)
	}
	
	func updateTask(model: ToDoList.MainScreenItemModel) {
		calls.append(.updateTask)
	}
	
	func fetchData(complition: @escaping (Result<[ToDoList.MainScreenItemModel], any Error>) -> ()) {
		calls.append(.fetchData)
	}
}
