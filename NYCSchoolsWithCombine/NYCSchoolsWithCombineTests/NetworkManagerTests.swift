//
//  NetworkManagerTests.swift
//  NYCSchoolsWithCombineTests
//
//  Created by iAskedYou2nd on 1/3/23.
//

import XCTest
import Combine
@testable import NYCSchoolsWithCombine

final class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager?
    private var subs = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.networkManager = NetworkManager(session: MockURLSession())
    }

    override func tearDownWithError() throws {
        self.networkManager = nil
        try super.tearDownWithError()
    }

    func testNetworkFetchSuccess() {
        let expectation = XCTestExpectation(description: "Successfully fetched data")
        var schoolResults: [School] = []
                
        self.networkManager?.requestModel(request: MockEnvironment.success.request)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail()
                case .finished:
                    print("Data Stream Closed")
                }
            }, receiveValue: { (schools: [School]) in
                schoolResults = schools
                expectation.fulfill()
            })
            .store(in: &self.subs)
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(schoolResults.count, 440)
        XCTAssertEqual(schoolResults.first?.schoolName, "Clinton School Writers & Artists, M.S. 260")
        XCTAssertEqual(schoolResults.first?.dbn, "02M260")
    }
    
    func testNetworkFetchRequestFail() {
        let expectation = XCTestExpectation(description: "Failed with a bad request")
        var failure: NetworkError?
        
        self.networkManager?.requestModel(request: nil)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    failure = error
                    expectation.fulfill()
                case .finished:
                    XCTFail()
                }
            }, receiveValue: { (_: [School]) in
                
            })
            .store(in: &self.subs)
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(failure, NetworkError.badRequest)
    }
    
    func testNetworkFetchStatusCodeFail() {
        let expectation = XCTestExpectation(description: "Failed with a bad status code")
        var failure: NetworkError?
        
        self.networkManager?.requestModel(request: MockEnvironment.mockStatusCodeFailure.request)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    failure = error
                    expectation.fulfill()
                case .finished:
                    XCTFail()
                }
            }, receiveValue: { (_: [School]) in
                
            })
            .store(in: &self.subs)
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(failure, NetworkError.badStatusCode(404))
    }
    
    func testNetworkFetchDecodeFail() {
        let expectation = XCTestExpectation(description: "Failed with a decode failure")
        var failure: NetworkError?
        
        self.networkManager?.requestModel(request: MockEnvironment.mockDecodeFailure.request)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    failure = error
                    expectation.fulfill()
                case .finished:
                    XCTFail()
                }
            }, receiveValue: { (_: [School]) in
                
            })
            .store(in: &self.subs)
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(failure, NetworkError.decodeError(DecodingError.typeMismatch(Array<Any>.self, DecodingError.Context(codingPath: [], debugDescription: "Expected to decode Array<Any> but found a dictionary instead."))))
    }
    
    func testNetworkFetchOtherFail() {
        let expectation = XCTestExpectation(description: "Failed with a general error")
        var failure: NetworkError?
        
        self.networkManager?.requestModel(request: MockEnvironment.mockOther.request)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    failure = error
                    expectation.fulfill()
                case .finished:
                    XCTFail()
                }
            }, receiveValue: { (_: [School]) in
                
            })
            .store(in: &self.subs)
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(failure, NetworkError.other(NSError(domain: "General Error", code: 222)))
    }

}
