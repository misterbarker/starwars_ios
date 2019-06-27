//
//  CharactersViewController.swift
//  StarWars
//
//  Created by Jason Barker on 6/18/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import UIKit
import CoreData

class CharactersViewController: UIViewController {

    @IBOutlet weak var zeroStateView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var charactersController: CharactersTableViewController?
    var managedObjectContext: NSManagedObjectContext?
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Star Wars Characters", comment: "Character list title")
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDataServiceDidFetchDataNotification(_:)), name: .dataServiceDidFetchDataNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDataServiceFetchDidFailNotification(_:)), name: .dataServiceFetchDidFailNotification, object: nil)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedObjectContext = appDelegate.persistentContainer.viewContext
            StarWarsDataService.shared.fetchData(container: appDelegate.persistentContainer)
        }
        
        configureView()
    }
    
    internal func configureView() {
        if StarWarsDataService.shared.isFetchInProgress {
            loadingIndicator.isHidden = false
            charactersController?.view.superview?.isHidden = true
            zeroStateView.isHidden = true
        } else {
            do {
                let request = StarWarsCharacter.fetchRequest() as NSFetchRequest<StarWarsCharacter>
                let count = try managedObjectContext?.count(for: request)
                if count == 0 {
                    loadingIndicator.isHidden = true
                    charactersController?.view.superview?.isHidden = true
                    zeroStateView.isHidden = false
                } else {
                    loadingIndicator.isHidden = true
                    charactersController?.view.superview?.isHidden = false
                    zeroStateView.isHidden = true
                }
            } catch {
                // show zero state
                loadingIndicator.isHidden = true
                charactersController?.view.superview?.isHidden = true
                zeroStateView.isHidden = false
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedCharactersTable" {
            guard let controller = segue.destination as? CharactersTableViewController else { return }
            charactersController = controller
            configureView()
        }
    }

    // MARK: - Handle notifications
    
    @objc
    func handleDataServiceDidFetchDataNotification(_ notification: Notification) {
        DispatchQueue.main.async { self.configureView() }
    }
    
    @objc
    func handleDataServiceFetchDidFailNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.configureView()
            
            let defaultMsg = NSLocalizedString("An unknown error has occurred.", comment: "Unknown error message")
            let message = notification.object as? String ?? defaultMsg
            let title = NSLocalizedString("Unable to load Star Wars characters", comment: "Data error alert message")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
