//
//  MainScreenInteractor.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//

import UIKit

protocol MainScreenPresenterOutput {
	func fetchTasks() -> [MainScreenItemModel]
}

final class MainScreenInteractor {
	weak var presenter: MainScreenPresenterInput?
	
	let dataManager: DataManager
	
	init( dataManager: DataManager) {
		self.dataManager = dataManager
	}
}

extension MainScreenInteractor: MainScreenPresenterOutput {
	func fetchTasks() -> [MainScreenItemModel] {
		return dataManager.fetchAllTasks()
	}
}
