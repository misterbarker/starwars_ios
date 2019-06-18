//
//  MockURLSessionDataTask.swift
//  StarWarsTests
//
//  Created by Jason Barker on 6/17/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    
    private let didResumeDataTask: () -> Void
    
    init(resumeAction: @escaping () -> Void) {
        didResumeDataTask = resumeAction
    }
    
    override func resume() {
        didResumeDataTask()
    }
}
