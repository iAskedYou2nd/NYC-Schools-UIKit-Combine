//
//  Session.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 1/3/23.
//

import Foundation
import Combine

protocol PublisherSession {
    func sessionPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), Error>
    func sessionPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error>
}

extension URLSession: PublisherSession {
    
    func sessionPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        return self.dataTaskPublisher(for: url).mapError({ urlError in
            return urlError as Error
        }).eraseToAnyPublisher()
    }
    
    func sessionPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        return self.dataTaskPublisher(for: request).mapError({ urlError in
            return urlError as Error
        }).eraseToAnyPublisher()
    }
    
}
