//
//  MovierError.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/2/24.
//

import Foundation

enum MovierError: Error {
    case httpError
    case urlFormatError
    case missingAccessToken
}
