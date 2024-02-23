//
//  Contact.swift
//  ContactsApplication
//
//  Created by Burak Eryavuz on 21.02.2024.
//

import Foundation

class Contact {
    var contact_id: Int?
    var contact_name: String?
    var contact_number: String?
    
    init(contact_id: Int? = nil, contact_name: String? = nil, contact_number: String? = nil) {
        self.contact_id = contact_id
        self.contact_name = contact_name
        self.contact_number = contact_number
    }
}
