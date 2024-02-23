//
//  ContactDetailVC.swift
//  ContactsApplication
//
//  Created by Burak Eryavuz on 21.02.2024.
//

import UIKit

class ContactDetailVC: UIViewController {

    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    
    var contact: Contact?
    
    var viewModel = ContactDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let currentContact = contact {
            contactNameLabel.text = currentContact.contact_name
            contactNumberLabel.text = currentContact.contact_number
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Update Contact", message: "", preferredStyle: .alert)
        
        alert.addTextField { contactNameTextField in
            contactNameTextField.placeholder = "Contact Name"
            contactNameTextField.keyboardType = .default
        }
        
        alert.addTextField { contactNumberTextField in
            contactNumberTextField.placeholder = "Contact Number"
            contactNumberTextField.keyboardType = .numberPad
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelAction)
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { action in
            if let textfields = alert.textFields {
                if let contactName = textfields[0].text, let contactNumber = textfields[1].text, let contact_id = self.contact?.contact_id {
                
                    self.viewModel.updateContact(contact_id: contact_id, contact_name: contactName, contact_number: contactNumber)
                    
                    self.contactNameLabel.text = contactName
                    self.contactNumberLabel.text = contactNumber
                    
                }
            }
        }
        alert.addAction(doneAction)
        
        present(alert, animated: true)
        
    }
    
    @IBAction func contactImageButtonPressed(_ sender: UIButton) {
    }
    
    
    
}
