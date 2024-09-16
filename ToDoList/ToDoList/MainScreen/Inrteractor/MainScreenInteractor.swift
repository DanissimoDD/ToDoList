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
	
	func fetchData(complition: @escaping (Result<[MainScreenItemModel], Error>) -> ())
}

final class MainScreenInteractor {
	
	private let dataManager: DataStore

	private let networkManager: NetworkManagerProtocol
	
	private let mapper: ResponseModelMapperProtocol
	
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
	
	func fetchData(complition: @escaping (Result<[MainScreenItemModel],Error>) -> ()) {
		networkManager.sendRequest { [weak self]
			result in
			guard let self else { return }
			
			switch result {
			case .success(let responseModel):
				let data = self.mapper.map(responseModel: responseModel)
				complition(.success(data))
				DispatchQueue.global(qos: .background).async { [weak self] in
					guard let self else { return }
					for model in data {
						dataManager.createTaskItem(model)
					}
				}
			case .failure(let error):
				complition(.failure(error))
			}
		}
	}
	
}
