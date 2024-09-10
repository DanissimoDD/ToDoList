//
//  DataManager.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//

import CoreData

final class DataManager {
	lazy var context = {
		let container = NSPersistentContainer(name: "ToDoListDataModel")
		container.loadPersistentStores { _, error in
			if let error {
				print(error.localizedDescription)
			}
		}
		return container.viewContext
	} ()
	
	private func saveContext() {
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				print(error.localizedDescription)
			}
		}
	}
	
	private func fetchAllTasks<MO: NSManagedObject>() -> [MO] {
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskItem")
		return (try? context.fetch(request) as? [MO]) ?? []
	}
	
	private func fetchMOWith<MO: NSManagedObject>(id: UUID) -> MO? {
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskItem")
		request.predicate = NSPredicate(format: "uid IN %@", [id])
		return (try? context.fetch(request).first as? MO?/*надо ли тут опционал*/) ?? nil
	}
}

extension DataManager {
	func createTaskItem(_ model: MainScreenItemModel) {
		let mo = TaskItem(context: context)
		mo.uid = model.uid
		mo.title = model.title
		mo.subtitle = model.subTitle
		mo.date = model.dateTime
		mo.hasDone = model.hasDone
		saveContext()
	}
	
	func fetchAllTasks() -> [MainScreenItemModel] {
		let mos: [TaskItem] = fetchAllTasks()
		return mos.map { MainScreenItemModel(mo: $0) }
	}
	
	func fetchTaskItemWith(id: UUID) -> MainScreenItemModel? {
		guard let mo: TaskItem = fetchMOWith(id: id) else { return nil }
		return MainScreenItemModel(mo: mo)
	}
	
	func updateTaskItem(model: MainScreenItemModel) {
		guard let mo: TaskItem = fetchMOWith(id: model.uid) else { return }
		mo.title = model.title
		mo.subtitle = model.subTitle
		mo.date = model.dateTime
		mo.hasDone = model.hasDone
		saveContext()
	}
	
	func deleteTaskItem(model: MainScreenItemModel) {
		guard let mo: TaskItem = fetchMOWith(id: model.uid) else { return }
		context.delete(mo)
		saveContext()
	}
}
