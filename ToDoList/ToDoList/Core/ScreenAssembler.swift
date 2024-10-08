//
//  ScreenFactory.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//

import UIKit

protocol ScreenAssemblerProtocol {
	func makeMainScreen(router: MainScreenRouter) -> MainScreenViewController
	
	func makeTaskScreen(router: TaskScreenRouter, model: MainScreenItemModel?) -> TaskScreenViewController
}

struct ScreenAssembler: ScreenAssemblerProtocol {
	
	private let dataManager = DataManager()
	
	private let userDefaults = Storage()
	
	func makeMainScreen(router: MainScreenRouter) -> MainScreenViewController {
		let interactor = MainScreenInteractor(dataManager: dataManager)
		let presenter = MainScreenPresenter(output: interactor, router: router, defaults: userDefaults)
		let vc = MainScreenViewController(presenter: presenter)
		presenter.view = vc
		return vc
	}
	
	func makeTaskScreen(router: TaskScreenRouter, model: MainScreenItemModel? = nil) -> TaskScreenViewController {
		let interactor = TaskScreenInteractor(dataManager: dataManager)
		let presenter = TaskScreenPresenter(router: router, output: interactor, model: model)
		let vc = TaskScreenViewController(presenter: presenter)
		presenter.view = vc
		return vc
	}
}
