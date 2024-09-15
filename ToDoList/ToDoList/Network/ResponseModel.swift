//
//  ResponseModel.swift
//  ToDoList
//
//  Created by Danil Viugov on 13.09.2024.
//

import Foundation

struct ResponseModel: Codable {
	let todos: [ItemModelJSON]
	let total: Int
	let skip: Int
	let limit: Int
}

struct ItemModelJSON: Codable {
	let id: Int
	let todo: String
	let completed: Bool
	let userId: Int
}
