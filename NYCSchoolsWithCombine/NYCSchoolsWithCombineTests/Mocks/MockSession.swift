//
//  MockSession.swift
//  NYCSchoolsWithCombineTests
//
//  Created by iAskedYou2nd on 1/3/23.
//

import Foundation
import Combine
@testable import NYCSchoolsWithCombine

class MockURLSession: PublisherSession {
    
    func sessionPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }
    
    func sessionPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        
        let urlStr = request.url?.absoluteString ?? "Fail"
        
        if urlStr.contains("StatusCodeFailure") {
            
            let data = Data()
            let response = HTTPURLResponse(url: request.url!, statusCode: 404, httpVersion: nil, headerFields: nil)!
            
            return Just((data: data, response: response))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else if urlStr.contains("DecodeFailure") {
            let sampleJSON = """
                            {
                                "test": "This should fail"
                            }
                            """
            let data = sampleJSON.data(using: .utf8)!
            
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            
            return Just((data: data, response: response))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else if urlStr.contains("GeneralFailure") {
            return Fail(error: NetworkError.other(NSError(domain: "General Error", code: 222))).eraseToAnyPublisher()
        } else { // Success Path
            guard let path = Bundle(for: NYCSchoolsWithCombineTests.self).path(forResource: "SchoolListSampleData", ofType: "json") else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            
            let url = URL(filePath: path)
            
            do {
                let data = try Data(contentsOf: url)
                
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
                
                return Just((data: data, response: response))
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
                
            } catch {
                print(error)
            }
            
            
        }
        
        return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }
    
    
    
    
    
    
    
    
    
}




