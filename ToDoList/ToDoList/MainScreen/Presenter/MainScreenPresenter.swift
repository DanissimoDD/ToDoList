//
//  MainScreenPresenter.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//

import UIKit

protocol MainScreenViewOutput {
	func viewDidLoad()
	
	func createNewTask()
	
	func anyCheckMarkTapped(item: Int)
	
	func saveChanges(index: Int)
	
	func showTask(index: Int)
}

protocol MainScreenPresenterInput: AnyObject {
	func dataDidLoad(models: [MainScreenItemModel])
	
	func showRequestError(message: String)
}

final class MainScreenPresenter {
	weak var view: MainScreenViewInput?
	
	private let router: MainScreenRouter
	
	private let output: MainScreenPresenterOutput
	
	private var defaults: StorageProtocol
	
	private var sectionsModel: [MainScreenSectionModel] = []
	
	private var itemModel: [MainScreenItemModel] = []
	
	private let dispatchGroup = DispatchGroup()
	
	init(output: MainScreenPresenterOutput, router: MainScreenRouter, defaults: StorageProtocol) {
		self.output = output
		self.router = router
		self.defaults = defaults
	}
}

extension MainScreenPresenter: MainScreenViewOutput {
	func showTask(index: Int) {
		router.goToTaskScreen(model: itemModel[index])
	}
	
	@objc func anyCheckMarkTapped(item: Int) {
		itemModel[item].hasDone.toggle() // проблема с тегами при удалении
		output.updateTask(model: itemModel[item])
		view?.updateDataSource(models: itemModel)
	}
	
	func createNewTask() {
		router.goToTaskScreen(model: nil)
	}
	
	func viewDidLoad() {
		if !defaults.isAppLounchedBefore {
			defaults.isAppLounchedBefore = true
			dispatchGroup.enter()
			output.fetchData { [weak self] in
				guard let self else { return }
				view?.updateDataSource(models: itemModel)
			}
		} else {
			itemModel = output.fetchTasks()
			view?.updateDataSource(models: itemModel)
		}
	}
	
	func saveChanges(index: Int) {
		output.updateTask(model: itemModel[index])
	}
}

extension MainScreenPresenter: MainScreenPresenterInput {
	func dataDidLoad(models: [MainScreenItemModel]) {
		itemModel = models
	}
	
	func showRequestError(message: String) {
		view?.showToast(message: message, duration: 2)
	}
}
