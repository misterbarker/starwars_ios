//
//  StarWarsDataService.swift
//  StarWars
//
//  Created by Jason Barker on 6/17/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import CoreData

public class StarWarsDataService {
    
    static let shared = StarWarsDataService()
    private let operationQueue = OperationQueue()
    private(set) var isFetchInProgress: Bool = false
    
    
    private init() {
        operationQueue.name = "Star Wars Data Operations Queue"
    }
    
    public func fetchData(container: NSPersistentContainer) {
        isFetchInProgress = true
        
        let fetch = FetchDataOperation()
        fetch.delegate = self
        
        let parse = ParseDataOperation()
        parse.delegate = self
        
        let save = SaveDataOperation(container: container)
        save.delegate = self
        save.completionBlock = {
            self.isFetchInProgress = false
            if !save.isCancelled {
                NotificationCenter.default.post(name: .dataServiceDidFetchDataNotification, object: nil)
            }
        }
        
        let transfer1 = BlockOperation {
            parse.data = fetch.data
        }
        
        let transfer2 = BlockOperation {
            save.characters = parse.characters
        }
        
        transfer1.addDependency(fetch)
        parse.addDependency(transfer1)
        transfer2.addDependency(parse)
        save.addDependency(transfer2)
        operationQueue.addOperations([fetch, transfer1, parse, transfer2, save], waitUntilFinished: false)
    }
}


extension StarWarsDataService: BaseOperationDelegate {
    
    func operation(operation: BaseOperation, failedWith error: Error) {
        NotificationCenter.default.post(name: .dataServiceFetchDidFailNotification, object: error.localizedDescription)
    }
}


extension Notification.Name {
    static let dataServiceFetchDidFailNotification = Notification.Name("dataServiceFetchDidFailNotification")
    static let dataServiceDidFetchDataNotification = Notification.Name("dataServiceDidFetchDataNotification")
}
