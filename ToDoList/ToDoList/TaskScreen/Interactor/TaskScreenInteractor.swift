//
//  TaskScreenInteractor.swift
//  ToDoList
//
//  Created by Danil Viugov on 12.09.2024.
//

import UIKit

protocol TaskScreenPresenterOutput {
	func createNewTaskMO(model: MainScreenItemModel)
	
	func updateTask(model: MainScreenItemModel)
	
	func deleteTask(modelId: UUID)
}

final class TaskScreenInteractor {
	
	private let dataManager: DataStore
	
	init( dataManager: DataStore) {
		self.dataManager = dataManager
	}
}

extension TaskScreenInteractor: TaskScreenPresenterOutput {
	func createNewTaskMO(model: MainScreenItemModel) {
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let self else { return }
			dataManager.createTaskItem(model)
		}
	}
	
	func updateTask(model: MainScreenItemModel) {
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let self else { return }
			dataManager.updateTaskItem(model: model)
		}
	}
	
	func deleteTask(modelId: UUID) {
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let self else { return }
			self.dataManager.deleteTaskItem(modelId: modelId)
		}
	}
}
