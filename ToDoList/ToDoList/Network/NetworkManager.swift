//
//  NetworkManager.swift
//  ToDoList
//
//  Created by Danil Viugov on 13.09.2024.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
	func sendRequest(completion: @escaping (Result<ResponseModel, Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
	
	private let endPoint: String = "https://dummyjson.com/todos"
	
	func sendRequest(completion: @escaping (Result<ResponseModel, Error>) -> Void) {
		AF.request(endPoint).validate(statusCode: 200..<300).responseDecodable(of: ResponseModel.self) { response in
			switch response.result {
			case .success(let responseModel):
				completion(.success(responseModel))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
