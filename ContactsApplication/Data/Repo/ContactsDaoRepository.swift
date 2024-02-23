//
//  ContactsDaoRepository.swift
//  ContactsApplication
//
//  Created by Burak Eryavuz on 23.02.2024.
//

import Foundation
import RxSwift

class ContactsDaoRepository {
     
    var contactsList = BehaviorSubject<[Contact]>(value: [Contact]())
    
    let db: FMDatabase?
    
    init() {
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: targetPath).appendingPathComponent("Contacts.sqlite")
        db = FMDatabase(path: databaseURL.path)
    }
    
    func saveContact(contact_name: String, contact_number: String) {
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO Contacts (contact_name, contact_number) VALUES (?, ?)", values: [contact_name, contact_number])
            print("Data was saved.")
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    func updateContact(contact_id: Int, contact_name: String, contact_number: String) {
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE Contacts SET contact_name = ?, contact_number = ? WHERE contact_id = ?", values: [contact_name, contact_number, contact_id])
            print("Data was updated")
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func remove(contact_id: Int) {
        db?.open()
        
        do {
            try db!.executeUpdate("DELETE FROM Contacts WHERE contact_id = ?", values: [ contact_id])
            print("Data was removed")
            loadContacts()
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    func search(searchText: String) {
        var contacts = [Contact]()

        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM Contacts WHERE contact_name LIKE '%\(searchText)%'", values: nil)
            while result.next() {
                let contact = Contact(contact_id: Int(result.string(forColumn: "contact_id"))!,
                                      contact_name: result.string(forColumn: "contact_name")!,
                                      contact_number: result.string(forColumn: "contact_number")!)
                
                contacts.append(contact)
            }
            
            contactsList.onNext(contacts)
        } catch {
            print(error.localizedDescription)
        }
        
        
        
        db?.close()
    }
    
    func loadContacts() {
        var contacts = [Contact]()

        db?.open()
        
        do {
            let result = try db!.executeQuery("SELECT * FROM Contacts", values: nil)
            while result.next() {
                let contact = Contact(contact_id: Int(result.string(forColumn: "contact_id"))!,
                                      contact_name: result.string(forColumn: "contact_name")!,
                                      contact_number: result.string(forColumn: "contact_number")!)
                
                contacts.append(contact)
            }
            
            contactsList.onNext(contacts)
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    
    
}
