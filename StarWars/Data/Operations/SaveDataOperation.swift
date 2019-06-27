//
//  SaveDataOperation.swift
//  StarWars
//
//  Created by Jason Barker on 6/27/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import CoreData

class SaveDataOperation: BaseOperation {
    
    var characters: [SWCharacter]?
    var persistentContainer: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        persistentContainer = container
        super.init()
    }
    
    override func main() {
        guard isCancelled == false else {
            _isFinished = true
            return
        }
        
        _isExecuting = true
        
        let context = persistentContainer.newBackgroundContext()
        
        // only delete existing data if there is something to replace it with
        if characters?.count ?? 0 > 0 {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: StarWarsCharacter.fetchRequest())
            do {
                try context.execute(deleteRequest)
            } catch {
                delegate?.operation(operation: self, failedWith: error)
            }
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        for c in characters ?? [] {
            let character = StarWarsCharacter(context: context)
            character.id = Int16(c.id)
            character.firstName = c.firstName
            character.lastName = c.lastName
            character.birthdate = formatter.date(from: c.birthdate)
            character.profilePictureUrl = URL(string: c.profilePicture)
            if let pictUrl = character.profilePictureUrl {
                character.profilePictureName = pictUrl.lastPathComponent
            }
            character.forceSensitive = c.forceSensitive
            character.affiliation = c.affiliationDescription
        }
        
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            delegate?.operation(operation: self, failedWith: error)
        }
        
        _isExecuting = false
        _isFinished = true
    }
}
