//
//  Router.swift
//  ToDoList
//
//  Created by Danil Viugov on 12.09.2024.
//

import UIKit

protocol RouterCore {
	var navigationController: UINavigationController { get set }
	
	var screenAssembler: ScreenAssembler { get set }
}

final class Router: RouterCore {
	
	var navigationController: UINavigationController
	
	var screenAssembler: ScreenAssembler
	
	init(
		navigationController: UINavigationController,
		screenAssembler: ScreenAssembler = ScreenAssembler()
	) {
		self.navigationController = navigationController
		self.screenAssembler = screenAssembler
		let vc = screenAssembler.makeMainScreen(router: self)
		navigationController.viewControllers  = [vc]
	}
}
