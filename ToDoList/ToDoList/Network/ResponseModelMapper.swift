//
//  ResponseModelMapper.swift
//  ToDoList
//
//  Created by Danil Viugov on 13.09.2024.
//

import Foundation

protocol ResponseModelMapperProtocol {
	func map(responseModel: ResponseModel) -> [MainScreenItemModel]
}

struct ResponseModelMapper: ResponseModelMapperProtocol {
	func map(responseModel: ResponseModel) -> [MainScreenItemModel] {
		responseModel.todos.map {
			MainScreenItemModel(itemModelJSON: $0)
		}
	}
}
