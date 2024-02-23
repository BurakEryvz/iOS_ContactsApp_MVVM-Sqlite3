//
//   HomepageViewModel.swift
//  ContactsApplication
//
//  Created by Burak Eryavuz on 23.02.2024.
//

import Foundation
import RxSwift

class HomepageViewModel {
    
    var contactsDaoRepository = ContactsDaoRepository()
    var contactsList = BehaviorSubject<[Contact]>(value: [Contact]())
    
    init() {
        copyDatabase()
        loadContacts()
        self.contactsList = contactsDaoRepository.contactsList
    }
    
    func remove(contactID: Int) {
        contactsDaoRepository.remove(contact_id: contactID)
    }
    
    func search(searchText: String) {
        contactsDaoRepository.search(searchText: searchText)
    }
    
    func loadContacts() {
        contactsDaoRepository.loadContacts()
    }
    
    func copyDatabase() {
        let bundlePath = Bundle.main.path(forResource: "Contacts", ofType: ".sqlite")
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let copyPath = URL(fileURLWithPath: targetPath).appendingPathComponent("Contacts.sqlite")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: copyPath.path) {
            print("Database already exist.")
        } else {
            do{
                try fileManager.copyItem(atPath: bundlePath!, toPath: copyPath.path)
            }catch{}
        }
    }
    
}
