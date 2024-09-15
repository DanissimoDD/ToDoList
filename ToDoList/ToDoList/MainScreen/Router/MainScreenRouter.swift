//
//  MainScreenRouter.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//

protocol MainScreenRouter {
	func goToTaskScreen(model: MainScreenItemModel?)
}

extension Router: MainScreenRouter {
	func goToTaskScreen(model: MainScreenItemModel?) {
		let vc = screenAssembler.makeTaskScreen(router: self, model: model)
		navigationController.pushViewController(vc, animated: true)
//		if #available(iOS 15.0, *), let sheet = vc.sheetPresentationController {
//			if #available(iOS 16.0, *) {
//				sheet.detents = [.custom { _ in 300 }, .large()]
//			} else {
//				sheet.detents = [.medium(), .large()]
//			}
//		}
//		navigationController.present(vc, animated: true)
	}
}
