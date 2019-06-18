//
//  ParseDataOperationTests.swift
//  StarWarsTests
//
//  Created by Jason Barker on 6/17/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import XCTest
@testable import StarWars

class ParseDataOperationTests: XCTestCase {
    
    var operationQueue: OperationQueue!
    var failureCompletion: ((Error) -> Void)?

    override func setUp() {
        super.setUp()
        operationQueue = OperationQueue()
    }

    override func tearDown() {
        super.tearDown()
    }

    
    /**
     Tests parsing for a properly formatted JSON record.
     */
    func testSuccessfulParse() {
        let promise = expectation(description: "Star Wars Character was successfully parsed")
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "ValidCharacter", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        
        let parse = ParseDataOperation()
        parse.data = data
        parse.completionBlock = {
            guard let character = parse.individuals?.first else {
                return
            }
            
            if character.id == 1
                && character.firstName == "Luke"
                && character.lastName == "Skywalker"
                && character.birthdate == "1963-05-05"
                && character.profilePicture == "https://edge.ldscdn.org/mobile/interview/07.png"
                && character.forceSensitive == true
                && character.affiliation == .JEDI
            {
                promise.fulfill()
            }
        }
        
        operationQueue.addOperation(parse)
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    /**
     Tests error handling for a malformatted JSON record.
     */
    func testCorruptedFormatParse() {
        let promise = expectation(description: "Successfully handled malformatted Star Wars Character")
        failureCompletion = { error in
            if error is DecodingError {
                promise.fulfill()
            }
        }

        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "InvalidCharacter", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        
        let parse = ParseDataOperation()
        parse.data = data
        parse.delegate = self
        
        operationQueue.addOperation(parse)
        waitForExpectations(timeout: 0.5, handler: nil)
    }
}

extension ParseDataOperationTests: BaseOperationDelegate {
    
    func operation(operation: BaseOperation, failedWith error: Error) {
        failureCompletion?(error)
    }
}
