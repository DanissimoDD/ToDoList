//
//  MainScreenInteractor.swift
//  ToDoList
//
//  Created by Danil Viugov on 10.09.2024.
//

import UIKit

protocol MainScreenPresenterOutput {
	func fetchTasks() -> [MainScreenItemModel]
	
	func createNewTaskMO(model: MainScreenItemModel)
	
	func updateTask(model: MainScreenItemModel)
	
	func fetchData(complition: @escaping () -> ())
}

final class MainScreenInteractor {
	
	private let dataManager: DataStore

	private let networkManager: NetworkManagerProtocol
	
	private let mapper: ResponseModelMapperProtocol
	
	weak var presenter: MainScreenPresenterInput?
	
	init(
		dataManager: DataStore,
		networkManager: NetworkManagerProtocol = NetworkManager(),
		mapper: ResponseModelMapperProtocol = ResponseModelMapper()
	) {
		self.dataManager = dataManager
		self.mapper = mapper
		self.networkManager = networkManager
	}
}

extension MainScreenInteractor: MainScreenPresenterOutput {
	func createNewTaskMO(model: MainScreenItemModel) {
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let self else { return }
			dataManager.createTaskItem(model)
		}
	}
	
	func fetchTasks() -> [MainScreenItemModel] {
		dataManager.fetchAllTasks()
	}
	
	func updateTask(model: MainScreenItemModel) {
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let self else { return }
			dataManager.updateTaskItem(model: model)
		}
	}
	
	func fetchData(complition: @escaping () -> ()) {
		networkManager.sendRequest { [weak self]
			result in
			guard let self else { return }
			
			switch result {
			case .success(let responseModel):
				let data = self.mapper.map(responseModel: responseModel)
				presenter?.dataDidLoad(models: data)
				DispatchQueue.global(qos: .background).async { [weak self] in
					guard let self else { return }
					for model in data {
						dataManager.createTaskItem(model)
					}
				}
				complition()
			case .failure(let error):
				presenter?.showRequestError(message: error.localizedDescription)
			}
		}
	}
	
}
