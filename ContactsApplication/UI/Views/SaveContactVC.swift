//
//  SaveContactVC.swift
//  ContactsApplication
//
//  Created by Burak Eryavuz on 21.02.2024.
//

import UIKit

class SaveContactVC: UIViewController {

    @IBOutlet weak var contactNameTextField: UITextField!
    @IBOutlet weak var contactNumberTextField: UITextField!
    
    var viewModel = SaveContactViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        
        if let contactName = contactNameTextField.text, let contactNumber = contactNumberTextField.text {
            
            viewModel.saveContact(contact_name: contactName, contact_number: contactNumber)
            
        }
    }
}
