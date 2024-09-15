//
//  DataManager.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//

import CoreData

protocol DataStore {
	func createTaskItem(_ model: MainScreenItemModel)
	
	func fetchAllTasks() -> [MainScreenItemModel]

	func updateTaskItem(model: MainScreenItemModel)

	func deleteTaskItem(modelId: UUID)
}

final class DataManager {
	
	lazy var container = {
		let container = NSPersistentContainer(name: "ToDoList")
		container.loadPersistentStores { _, error in
			if let error {
				print(error.localizedDescription)
			}
		}
		return container
	} ()
	
	lazy var context = container.viewContext
	
	lazy var backgroundContext = {
		let backgroundContext = container.newBackgroundContext()
		backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
		return backgroundContext
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
	
	private func saveBackgroundContext() {
		do {
			try backgroundContext.save()
		} catch {
			print(error.localizedDescription)
		}
	}
	
	private func fetchAllTasks<MO: NSManagedObject>() -> [MO] {
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskItem")
		return (try? context.fetch(request) as? [MO]) ?? []
	}
	
	private func fetchMOWith<MO: NSManagedObject>(id: UUID) -> MO? {
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskItem")
		request.predicate = NSPredicate(format: "uid IN %@", [id])
		return (try? context.fetch(request).first as? MO?) ?? nil
	}
}

extension DataManager: DataStore {
	func createTaskItem(_ model: MainScreenItemModel) {
		backgroundContext.perform { [weak self] in
			guard let self else { return }
			let mo = TaskItem(context: backgroundContext)
			mo.uid = model.uid
			mo.title = model.title
			mo.subtitle = model.subTitle
			mo.date = model.dateTime
			mo.hasDone = model.hasDone
			saveBackgroundContext()
		}
	}
	
	func fetchAllTasks() -> [MainScreenItemModel] {
		var mos: [TaskItem] = []
		context.performAndWait {
			mos = fetchAllTasks()
		}
		return mos.map { MainScreenItemModel(mo: $0) }
	}
	
//	func fetchTaskItemWith(id: UUID) -> MainScreenItemModel? {
//		guard let mo: TaskItem = fetchMOWith(id: id) else { return nil }
//		return MainScreenItemModel(mo: mo)
//	}

	// Надо обновлять сразу по одному в бэкграунде, так похоже не успевает
	func updateTaskItem(model: MainScreenItemModel) {
		
		let objectId = fetchMOWith(id: model.uid)?.objectID
		backgroundContext.perform { [weak self] in
			guard let self, let objectId = objectId else { return }
			
			let mo = backgroundContext.object(with: objectId) as! TaskItem
			
			mo.title = model.title
			mo.subtitle = model.subTitle
			mo.date = model.dateTime
			mo.hasDone = model.hasDone
			
//		saveContext()
			saveBackgroundContext()
		}
	}

	func deleteTaskItem(modelId: UUID) {
		
		let objectId = fetchMOWith(id: modelId)?.objectID
  
		backgroundContext.performAndWait { [weak self] in
			guard let self, let objectId = objectId else { return }
			
			let mo = backgroundContext.object(with: objectId)
			backgroundContext.delete(mo)
			saveBackgroundContext()
		}
	}
}
