//
//  DataStore.swift
//  StarWars
//
//  Created by Jason Barker on 6/18/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import Foundation

public class DataStore {
    
    static let shared = DataStore()
    
    var records: [StarWarsCharacter]? {
        didSet {
            NotificationCenter.default.post(name: .dataResetNotification, object: nil)
        }
    }
    
    private init() { }
}


extension Notification.Name {
    static let dataResetNotification = Notification.Name("dataResetNotification")
}
