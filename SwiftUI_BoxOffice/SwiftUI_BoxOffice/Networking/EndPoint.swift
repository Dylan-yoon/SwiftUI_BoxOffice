//
//  EndPoint.swift
//  SwiftUI_BoxOffice
//
//  Created by Dylan_Y on 3/6/24.
//

import Foundation

final class EndPoint {
    private let baseURL: String
    private let path: String
    private var scheme: String
    private var queryItems: [URLQueryItem]
    var headers: [String: String]
    let method: HTTPMethod
    
    init(baseURL: String,
         path: String, 
         scheme: String = "https", 
         queryItems: [URLQueryItem] = [],
         headers: Dictionary<String, String> = [:],
         method: HTTPMethod) {
        self.baseURL = baseURL
        self.path = path
        self.scheme = scheme
        self.queryItems = queryItems
        self.method = method
        self.headers = headers
    }
    
    func generateURL() -> URLComponents {
        var resultUrlComponents = URLComponents()
        
        resultUrlComponents.scheme = scheme
        resultUrlComponents.host = baseURL
        resultUrlComponents.path = path
        resultUrlComponents.queryItems = queryItems
        
        return resultUrlComponents
    }
    
    func add(queryItem: URLQueryItem) {
        queryItems.append(queryItem)
    }
}
