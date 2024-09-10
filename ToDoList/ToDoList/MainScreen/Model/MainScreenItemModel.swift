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
}

extension MainScreenItemModel {
	init(mo: TaskItem) {
		uid = mo.uid
		title = mo.title
		subTitle = mo.subtitle
		dateTime = mo.date
		hasDone = mo.hasDone
	}
}
