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
		itemModel[item].hasDone.toggle()
		output.updateTask(model: itemModel[item])
		view?.updateDataSource(models: itemModel)
	}
	
	func createNewTask() {
		router.goToTaskScreen(model: nil)
	}
	
	func viewDidLoad() {
		if !defaults.isAppLounchedBefore {
			defaults.isAppLounchedBefore = true
			output.fetchData { [weak self] result in
				guard let self else { return }
				switch result {
				case .success(let models):
					itemModel = models
					view?.updateDataSource(models: itemModel)
				case .failure(let error):
					view?.showToast(message: error.localizedDescription, duration: 2)
				}
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
