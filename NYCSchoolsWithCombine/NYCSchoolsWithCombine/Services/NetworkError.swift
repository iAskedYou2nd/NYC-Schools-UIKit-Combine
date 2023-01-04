//
//  NetworkError.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 12/29/22.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case badStatusCode(Int)
    case decodeError(Error)
    case other(Error)
}

extension NetworkError: LocalizedError, Equatable {
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
    
    var localizedDescription: String {
        switch self {
        case .badRequest:
            return NSLocalizedString("Bad Request", comment: "Bad Request")
        case .badStatusCode(let code):
            return NSLocalizedString("Bad Status Code: \(code)", comment: "Bad Status Code")
        case .decodeError(let err):
            return NSLocalizedString("Decode Error for: \(err)", comment: "Decode Error")
        case .other(let err):
            return NSLocalizedString("Generic Error for: \(err)", comment: "Generic Error")
        }
    }
    
    
    
    
    
}
