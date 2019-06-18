//
//  CharactersTableViewController.swift
//  StarWars
//
//  Created by Jason Barker on 6/18/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import UIKit

class CharactersTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDataResetNotification(_:)), name: .dataResetNotification, object: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStore.shared.records?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("Expected cell type: CharacterTableViewCell")
        }
        
        cell.character = DataStore.shared.records?[indexPath.row]
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacterDetail" {
            guard let controller = segue.destination as? CharacterDetailViewController else { return }
            
            if let index = tableView.indexPathForSelectedRow?.row {
                controller.character = DataStore.shared.records?[index]
            }
        }
    }
    
    // MARK: - Handle notifications
    
    @objc
    func handleDataResetNotification(_ notification: Notification) {
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
}
