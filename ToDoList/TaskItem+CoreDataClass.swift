//
//  TaskItem+CoreDataClass.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//
//

import Foundation
import CoreData

@objc(TaskItem)
public class TaskItem: NSManagedObject {

}

extension TaskItem {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
		return NSFetchRequest<TaskItem>(entityName: "TaskItem")
	}

	@NSManaged public var uid: UUID
	@NSManaged public var title: String
	@NSManaged public var subtitle: String
	@NSManaged public var date: Date
	@NSManaged public var hasDone: Bool

}

extension TaskItem : Identifiable {

}
