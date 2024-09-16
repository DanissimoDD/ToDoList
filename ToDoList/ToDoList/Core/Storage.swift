//
//  Storage.swift
//  ToDoList
//
//  Created by Danil Viugov on 13.09.2024.
//

import Foundation

protocol StorageProtocol {
	var isAppLounchedBefore: Bool { get set }
}

final class Storage {
	
	private enum States: String {
		case isAppLounchedBefore
	}
	
	private let defaults = UserDefaults.standard
}

extension Storage: StorageProtocol {
	var isAppLounchedBefore: Bool {
		get { return defaults.bool(forKey: States.isAppLounchedBefore.rawValue)}
		set { defaults.setValue(newValue, forKey: States.isAppLounchedBefore.rawValue)}
	}
}
