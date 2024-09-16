//
//  ResponseModelMapperMock.swift
//  ToDoListTests
//
//  Created by Danil Viugov on 16.09.2024.
//

import Foundation
@testable import ToDoList

final class ResponseModelMapperMock {
	
	enum Call {
	case map
	}
	
	private(set) var calls: [Call] = []
}

extension ResponseModelMapperMock: ResponseModelMapperProtocol {
	func map(responseModel: ToDoList.ResponseModel) -> [ToDoList.MainScreenItemModel] {
		calls.append(.map)
		return [
			MainScreenItemModel(
				title: "task",
				subTitle: "",
				dateTime: Date(),
				hasDone: false
			)
		]
	}
}
