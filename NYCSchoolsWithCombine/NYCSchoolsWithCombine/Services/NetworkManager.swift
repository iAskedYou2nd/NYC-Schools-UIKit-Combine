//
//  NetworkManager.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 12/29/22.
//

import Foundation
import Combine

protocol Network {
    func requestModel<T: Decodable>(request: URLRequest?) -> AnyPublisher<T, NetworkError>
}

class NetworkManager {
    
    let session: PublisherSession
    let decoder: JSONDecoder
    
    init(session: PublisherSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder(), decodeStrategy: JSONDecoder.KeyDecodingStrategy? = .convertFromSnakeCase) {
        self.session = session
        if let strategy = decodeStrategy {
            decoder.keyDecodingStrategy = strategy
        }
        self.decoder = decoder
    }
    
}

extension NetworkManager: Network {
    
    func requestModel<T: Decodable>(request: URLRequest?) -> AnyPublisher<T, NetworkError> {
        
        guard let request = request else {
            return Fail(error: NetworkError.badRequest).eraseToAnyPublisher()
        }
        
        return self.session.sessionPublisher(for: request)
            .tryMap { payload in
                if let httpResponse = payload.response as? HTTPURLResponse,
                   !(200..<300).contains(httpResponse.statusCode) {
                    throw NetworkError.badStatusCode(httpResponse.statusCode)
                }
                return payload.data
            }
            .decode(type: T.self, decoder: self.decoder)
            .mapError { error in
                if let decodeErr = error as? DecodingError {
                    return NetworkError.decodeError(decodeErr)
                } else if let networkError = error as? NetworkError {
                    return networkError
                }
                return NetworkError.other(error)
            }.eraseToAnyPublisher()
        
    }
    
}


