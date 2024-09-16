//
//  MockMainScreenViewController.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 16.09.2024.
//

@testable import ToDoList
import Foundation

final class MainScreenViewControllerMock {
	
	enum Call {
		case updateDataSource
		case showToast
	}
	
	private(set) var calls: [Call] = []
}

extension MainScreenViewControllerMock: MainScreenViewInput {
	func updateDataSource(models: [ToDoList.MainScreenItemModel]) {
		calls.append(.updateDataSource)
	}
	
	func showToast(message: String, duration: TimeInterval) {
		calls.append(.showToast)
	}
}
