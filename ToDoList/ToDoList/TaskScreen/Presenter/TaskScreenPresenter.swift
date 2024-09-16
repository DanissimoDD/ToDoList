//
//  TaskScreenPresenter.swift
//  ToDoList
//
//  Created by Danil Viugov on 12.09.2024.
//

import Foundation

protocol TaskScreenViewOutput {
	func viewDidLoad()
	
	func finishTaskCreation(newModel: TaskScreenModel)
	
	func taskDeletion()
	
	func isEditMode() -> Bool
}

final class TaskScreenPresenter {
	weak var view: TaskScreenViewInput?
	
	private let router: TaskScreenRouter
	
	private let output: TaskScreenPresenterOutput
	
	private var model: MainScreenItemModel?
	
	init(router: TaskScreenRouter, output: TaskScreenPresenterOutput, model: MainScreenItemModel? = nil) {
		self.output = output
		self.router = router
		self.model = model
	}
}

extension TaskScreenPresenter: TaskScreenViewOutput {
	func isEditMode() -> Bool {
		self.model != nil
	}
	
	func taskDeletion() {
		guard let id = model?.uid else { return }
		output.deleteTask(modelId: id)
		router.returnToMainScreen()
	}
	
	func finishTaskCreation(newModel: TaskScreenModel) {
		if var model = self.model {
			model.title = newModel.title
			model.subTitle = newModel.subTitle
			model.dateTime = newModel.dateTime
			output.updateTask(model: model)
		} else {
			output.createNewTaskMO(model: MainScreenItemModel(model: newModel))
		}
		router.returnToMainScreen()
	}
	
	func viewDidLoad() {
		guard let model else { return }
		view?.setData(model: model)
	}
	
}
