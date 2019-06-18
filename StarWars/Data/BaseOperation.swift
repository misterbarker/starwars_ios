//
//  BaseOperation.swift
//  StarWars
//
//  Created by Jason Barker on 6/15/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import Foundation

protocol BaseOperationDelegate {
    func operation(operation: BaseOperation, failedWith error: Error)
}

class BaseOperation: Operation {
    
    var delegate: BaseOperationDelegate?
    
    override var isAsynchronous: Bool { get { return _isAsynchronous } }
    override var isExecuting: Bool { get { return _isExecuting } }
    override var isFinished: Bool { get { return _isFinished } }
    
    internal var _isAsynchronous: Bool = false {
        willSet { willChangeValue(forKey: #keyPath(isAsynchronous)) }
        didSet { didChangeValue(forKey: #keyPath(isAsynchronous)) }
    }
    
    internal var _isExecuting: Bool = false {
        willSet { willChangeValue(forKey: #keyPath(isExecuting)) }
        didSet { didChangeValue(forKey: #keyPath(isExecuting)) }
    }
    
    internal var _isFinished: Bool = false {
        willSet { willChangeValue(forKey: #keyPath(isFinished)) }
        didSet { didChangeValue(forKey: #keyPath(isFinished)) }
    }
}
