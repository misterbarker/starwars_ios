//
//  FetchDataOperationTests.swift
//  StarWarsTests
//
//  Created by Jason Barker on 6/15/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import XCTest
@testable import StarWars

enum FetchDataTestError: Error {
    case testFailure
}

class FetchDataOperationTests: XCTestCase {
    
    var operationQueue: OperationQueue!
    var failureCompletion: ((Error) -> Void)?
    
    override func setUp() {
        super.setUp()
        operationQueue = OperationQueue()
    }
    
    override func tearDown() {
        failureCompletion = nil
        super.tearDown()
    }

    
    /**
     Tests that the operation's `data` variable is set for a successful fetch.
     */
    func testSuccessfulFetch() {
        let data = "Test".data(using: .utf8)
        let promise = expectation(description: "fetch completed")
        let session = MockURLSession(data: data, urlResponse: nil, error: nil)
        
        let fetch = FetchDataOperation(session: session)
        fetch.completionBlock = {
            if fetch.data == data {
                promise.fulfill()
            }
        }
        
        operationQueue.addOperation(fetch)
        waitForExpectations(timeout: 0.5, handler: nil)
    }

    /**
     Tests whether the delegate's `operation:failedWith:` function is invoked when an error is encountered
     during the fetch.
     */
    func testFailedFetch() {
        let promise = expectation(description: "fetch failure handled properly")
        
        failureCompletion = { error in
            if let err = error as? FetchDataTestError, err == FetchDataTestError.testFailure {
                promise.fulfill()
            }
        }
        
        let session = MockURLSession(data: nil, urlResponse: nil, error: FetchDataTestError.testFailure)
        let fetch = FetchDataOperation(session: session)
        fetch.delegate = self
        
        operationQueue.addOperation(fetch)
        waitForExpectations(timeout: 0.5, handler: nil)
    }
}


extension FetchDataOperationTests: BaseOperationDelegate {
    
    func operation(operation: BaseOperation, failedWith error: Error) {
        failureCompletion?(error)
    }
}
