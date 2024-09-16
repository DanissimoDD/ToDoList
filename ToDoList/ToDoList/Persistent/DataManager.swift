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
	
	private lazy var container = {
		let container = NSPersistentContainer(name: "ToDoList")
		container.loadPersistentStores { _, error in
			if let error {
				fatalError(error.localizedDescription)
			}
		}
		return container
	} ()
	
	private lazy var context = container.viewContext
	
	private lazy var backgroundContext = {
		let backgroundContext = container.newBackgroundContext()
		backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
		return backgroundContext
	} ()
	
	private func saveContext() {
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				fatalError(error.localizedDescription)
			}
		}
	}
	
	private func saveBackgroundContext() {
		do {
			try backgroundContext.save()
		} catch {
			fatalError(error.localizedDescription)
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
		mos = fetchAllTasks()
		return mos.map { MainScreenItemModel(mo: $0) }
	}

	func updateTaskItem(model: MainScreenItemModel) {
		
		let objectId = fetchMOWith(id: model.uid)?.objectID
		backgroundContext.perform { [weak self] in
			guard let self,
				  let objectId,
				  let mo = backgroundContext.object(with: objectId) as? TaskItem else { return }
			
			mo.title = model.title
			mo.subtitle = model.subTitle
			mo.date = model.dateTime
			mo.hasDone = model.hasDone
			
			saveBackgroundContext()
		}
	}

	func deleteTaskItem(modelId: UUID) {
		
		let objectId = fetchMOWith(id: modelId)?.objectID
  
		backgroundContext.performAndWait { [weak self] in
			guard let self,
				  let objectId = objectId else { return }
			
			let mo = backgroundContext.object(with: objectId)
			backgroundContext.delete(mo)
			saveBackgroundContext()
		}
	}
}
