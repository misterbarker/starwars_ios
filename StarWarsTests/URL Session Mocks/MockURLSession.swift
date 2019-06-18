//
//  MockURLSession.swift
//  StarWarsTests
//
//  Created by Jason Barker on 6/17/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    
    typealias URLSessionCompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.error = error
    }

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask {
            completionHandler(self.data, self.urlResponse, self.error)
        }
    }
}
