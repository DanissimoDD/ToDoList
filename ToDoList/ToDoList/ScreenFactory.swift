//
//  ScreenFactory.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//

import UIKit

struct ScreenFactory {
	func makeMainScreen() -> MainScreenViewController {
		let interactor = MainScreenInteractor(dataManager: DataManager())
		let presenter = MainScreenPresenter(output: interactor)
		interactor.presenter = presenter
		let vc = MainScreenViewController(presenter: presenter)
		presenter.view = vc
		return vc
	}
}
