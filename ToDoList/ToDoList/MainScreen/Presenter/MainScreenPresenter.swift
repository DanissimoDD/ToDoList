//
//  MainScreenPresenter.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//

import UIKit

protocol MainScreenPresenterInput: AnyObject {
	
}

protocol MainScreenViewOutput {
	func onButtonTapped()
}

final class MainScreenPresenter {
	weak var view: MainScreenViewInput?
	
	let output: MainScreenPresenterOutput
	
	var sectionsModel: [MainScreenSectionModel] = []
	
	var itemModel: [MainScreenItemModel] = []
	
	init(output: MainScreenPresenterOutput) {
		self.output = output
	}
}

extension MainScreenPresenter: MainScreenViewOutput {
	
}

extension MainScreenPresenter: MainScreenPresenterInput {
	func onButtonTapped() {
		view?.updateDataSource(models: output.fetchTasks())
	}
}
