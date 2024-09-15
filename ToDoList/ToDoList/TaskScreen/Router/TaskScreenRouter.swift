//
//  TaskScreenRouter.swift
//  ToDoList
//
//  Created by Danil Viugov on 12.09.2024.
//

import Foundation

protocol TaskScreenRouter {
	func returnToMainScreen()
}

extension Router: TaskScreenRouter {
	func returnToMainScreen() {
//		navigationController.dismiss(animated: true)
		navigationController.popViewController(animated: true)
	}
}
