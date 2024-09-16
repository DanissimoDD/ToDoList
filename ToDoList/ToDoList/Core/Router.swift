//
//  Router.swift
//  ToDoList
//
//  Created by Danil Viugov on 12.09.2024.
//

import UIKit

protocol RouterCore {
	var navigationController: UINavigationController { get set }
}

final class Router: RouterCore {
	
	var navigationController: UINavigationController
	
	private let screenAssembler: ScreenAssemblerProtocol
	
	init(
		navigationController: UINavigationController,
		screenAssembler: ScreenAssemblerProtocol
	) {
		self.navigationController = navigationController
		self.screenAssembler = screenAssembler
		let vc = screenAssembler.makeMainScreen(router: self)
		navigationController.viewControllers  = [vc]
	}
}

extension Router: MainScreenRouter {
	func goToTaskScreen(model: MainScreenItemModel?) {
		let vc = screenAssembler.makeTaskScreen(router: self, model: model)
		navigationController.pushViewController(vc, animated: true)
	}
}
