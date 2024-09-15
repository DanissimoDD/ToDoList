//
//  TaskScreenModel.swift
//  ToDoList
//
//  Created by Danil Viugov on 12.09.2024.
//

import Foundation

struct TaskScreenModel {
	private(set) var uid = UUID()
	var title: String
	var subTitle: String
	var dateTime: Date
}

// Потом убрать сделать одну модель
extension TaskScreenModel {
	init(model: MainScreenItemModel) {
		uid = model.uid
		title = model.title
		subTitle = model.subTitle
		dateTime = model.dateTime
	}
}
