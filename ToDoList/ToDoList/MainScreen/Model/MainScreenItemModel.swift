//
//  MainScreenItemModel.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//

import UIKit

struct MainScreenItemModel: Hashable {
	private(set) var uid = UUID()
	var title: String
	var subTitle: String
	var dateTime: Date
	var hasDone: Bool
	
	init(title: String, subTitle: String, dateTime: Date, hasDone: Bool) {
		self.title = title
		self.subTitle = subTitle
		self.dateTime = dateTime
		self.hasDone = hasDone
	}

	init(mo: TaskItem) {
		uid = mo.uid
		title = mo.title
		subTitle = mo.subtitle
		dateTime = mo.date
		hasDone = mo.hasDone
	}
	
	init(model: TaskScreenModel) {
		uid = model.uid
		title = model.title
		subTitle = model.subTitle
		dateTime = model.dateTime
		hasDone = false
	}
	
	init(itemModelJSON: ItemModelJSON) {
		title = itemModelJSON.todo
		subTitle = ""
		dateTime = Date()
		hasDone = itemModelJSON.completed
	}
}
