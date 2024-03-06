//
//  NetworkManager.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/6/24.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(endpoint: EndPoint, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        guard let url = endpoint.generateURL().url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.defaultsError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.responseError))
                return
            }
            
            debugPrint("NETWORK RESPONSE: ", response.statusCode)
            
            guard let data = data else {
                completion(.failure(.getDataError))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case defaultsError
    case responseError
    case getDataError
    case informationalResponses
    case redirectionMessages
    case clientErrorResponses
    case serverErrorResponses
}
