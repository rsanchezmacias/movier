//
//  DataTaskFactory.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/2/24.
//

import Foundation

protocol DataTaskFactoryProtocol {
    
    func dataTask<T>(
        forSession urlSession: URLSession,
        request: URLRequest,
        resultType: T.Type,
        onSucceed: @escaping (T, URLResponse?, Data?) -> Void,
        onFail: @escaping (Error?, URLResponse?, Data?) -> Void
    ) -> URLSessionDataTask where T: Decodable
    
}

class DataTaskFactory: DataTaskFactoryProtocol {
    
    private let decoder = JSONDecoder()
    
    func dataTask<T>(
        forSession urlSession: URLSession,
        request: URLRequest,
        resultType: T.Type,
        onSucceed: @escaping (T, URLResponse?, Data?) -> Void,
        onFail: @escaping (Error?, URLResponse?, Data?) -> Void
    ) -> URLSessionDataTask where T: Decodable {
        return urlSession.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if response?.isStatusCodeSuccessful == false {
                onFail(error, response, data)
                return
            }
            
            if let data = data {
                do {
                    let result = try self.decoder.decode(resultType, from: data)
                    onSucceed(result, response, data)
                } catch {
                    onFail(error, response, data)
                }
            } else {
                onFail(error, response, data)
            }
        }
    }
    
}
