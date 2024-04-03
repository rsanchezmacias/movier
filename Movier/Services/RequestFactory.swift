//
//  RequestFactory.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/2/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol RequestFactoryProtocol {
    func request(method: HTTPMethod, serviceURL: URL, queryItems: [URLQueryItem], body: Data?, authentication: String?) -> URLRequest
}

class RequestFactory: RequestFactoryProtocol {
    
    func request(
        method: HTTPMethod,
        serviceURL: URL,
        queryItems: [URLQueryItem] = [],
        body: Data? = nil,
        authentication: String? = nil
    ) -> URLRequest {
        
        var urlComponents = URLComponents(string: serviceURL.absoluteString)
        urlComponents?.queryItems = queryItems
        
        guard let fullServiceURL = urlComponents?.url else {
            return URLRequest(url: serviceURL)
        }
        
        var request = URLRequest(url: fullServiceURL)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        if let authentication = authentication {
            request.addValue("Bearer \(authentication)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
}
