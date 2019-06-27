//
//  CharactersTableViewController.swift
//  StarWars
//
//  Created by Jason Barker on 6/18/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import UIKit
import CoreData

class CharactersTableViewController: UITableViewController {
    
    internal var characters: [StarWarsCharacter] = []

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleDataServiceDidFetchDataNotification(_:)),
                                               name: .dataServiceDidFetchDataNotification,
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCharacters { self.tableView.reloadData() }
    }
    
    func loadCharacters(_ completion: ()->()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let request = StarWarsCharacter.fetchRequest() as NSFetchRequest<StarWarsCharacter>
        request.sortDescriptors = [NSSortDescriptor(keyPath: \StarWarsCharacter.firstName, ascending: true)]
        
        let context = appDelegate.persistentContainer.viewContext
        let records = try? context.fetch(request)
        characters = records ?? []
        
        completion()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("Expected cell type: CharacterTableViewCell")
        }
        
        cell.character = characters[indexPath.row]
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacterDetail" {
            guard let controller = segue.destination as? CharacterDetailViewController else { return }
            
            if let index = tableView.indexPathForSelectedRow?.row {
                controller.character = characters[index]
            }
        }
    }
    
    // MARK: - Handle notifications
    
    @objc
    func handleDataServiceDidFetchDataNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.loadCharacters {
                self.tableView.reloadData()
            }
        }
    }
}
