//
//  StarWarsDataService.swift
//  StarWars
//
//  Created by Jason Barker on 6/17/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import Foundation

public class StarWarsDataService {
    
    static let shared = StarWarsDataService()
    private let operationQueue = OperationQueue()
    private(set) var isFetchInProgress: Bool = false
    
    
    private init() {
        operationQueue.name = "Star Wars Data Operations Queue"
    }
    
    public func fetchData() {
        isFetchInProgress = true
        
        let fetch = FetchDataOperation()
        fetch.delegate = self
        
        let parse = ParseDataOperation()
        parse.delegate = self
        
        let transfer = BlockOperation { parse.data = fetch.data }
        
        parse.completionBlock = {
            self.isFetchInProgress = false
            if !parse.isCancelled {
                DataStore.shared.records = parse.individuals
            }
        }
        
        transfer.addDependency(fetch)
        parse.addDependency(transfer)
        operationQueue.addOperations([fetch, transfer, parse], waitUntilFinished: false)
    }
}


extension StarWarsDataService: BaseOperationDelegate {
    
    func operation(operation: BaseOperation, failedWith error: Error) {
        NotificationCenter.default.post(name: .dataFetchFailedNotification, object: error.localizedDescription)
    }
}


extension Notification.Name {
    static let dataFetchFailedNotification = Notification.Name("dataFetchFailedNotification")
}
