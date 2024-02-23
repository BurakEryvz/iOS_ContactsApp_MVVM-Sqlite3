//
//  SaveContactViewModel.swift
//  ContactsApplication
//
//  Created by Burak Eryavuz on 23.02.2024.
//

import Foundation

class SaveContactViewModel {
    
    var contactSDaoRepository = ContactsDaoRepository()
    
    func saveContact(contact_name: String, contact_number: String) {
        contactSDaoRepository.saveContact(contact_name: contact_name, contact_number: contact_number )
    }
}
