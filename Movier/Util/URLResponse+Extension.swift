//
//  URLResponse+Extension.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/2/24.
//

import Foundation

extension URLResponse {
    
    var isStatusCodeSuccessful: Bool {
        guard let httpResponse = self as? HTTPURLResponse else {
            return false
        }
        
        return (200..<300).contains(httpResponse.statusCode)
    }
    
}
