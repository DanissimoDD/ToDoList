//
//  NetworkManagerMock.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 16.09.2024.
//

@testable import ToDoList

final class NetworkManagerMock {
	
	enum Call {
	case sendRequest
	}
	
	private(set) var calls: [Call] = []
}

extension NetworkManagerMock: NetworkManagerProtocol {
	func sendRequest(completion: @escaping (Result<ToDoList.ResponseModel, any Error>) -> Void) {
		calls.append(.sendRequest)
		completion(
			.success(
				ResponseModel(
					todos: [ItemModelJSON(id: 1, todo: "task", completed: true, userId: 2)],
					total: 0,
					skip: 0,
					limit: 0
				)
			)
		)
	}
}
