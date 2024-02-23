//
//  ViewController.swift
//  ContactsApplication
//
//  Created by Burak Eryavuz on 21.02.2024.
//

import UIKit
import RxSwift

class HomepageVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var contacts = [Contact]()
    
    var viewModel = HomepageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        _ = viewModel.contactsList.subscribe(onNext: { contacts in
            self.contacts = contacts
            self.tableView.reloadData()
        })
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("HomepageVC appeared")
        viewModel.loadContacts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoContactDetail" {
            if let data = sender as? Contact {
                let contactDetailVC = segue.destination as! ContactDetailVC
                contactDetailVC.contact = data
            }
        }
    }


}

extension HomepageVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.search(searchText: searchText)
    }
    
}

extension HomepageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContactCell
        
        cell.contactNameLabel.text = contacts[indexPath.row].contact_name
        cell.contactNumberLabel.text = contacts[indexPath.row].contact_number
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "GoContactDetail", sender: contacts[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Remove") { contextualAction, view, bool in
            
            let selectedContact = self.contacts[indexPath.row]
            
            let alert = UIAlertController(title: "Remove the \(selectedContact.contact_name ?? "Contact") ?", message: "", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                
            }
            alert.addAction(cancelAction)
            
            let removeAction = UIAlertAction(title: "Remove", style: .destructive) { action in
                self.viewModel.remove(contactID: selectedContact.contact_id!)
                
            }
            alert.addAction(removeAction)
            
            self.present(alert, animated: true)
            
    }
        
        
        
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
    
}

