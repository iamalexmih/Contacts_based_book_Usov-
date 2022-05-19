//
//  Contact.swift
//  usov_alex_Contacts
//
//  Created by Алексей Попроцкий on 18.05.2022.
//

import Foundation

protocol ContactProtocol {
    var title: String {get set}
    var phone: String {get set}
}

protocol ContactStorageProtocol {
    func load() -> [ContactProtocol]
    func save(contacts: [ContactProtocol])
}

struct Contact: ContactProtocol {
    
    var title: String
    var phone: String
    
}

class ContactStorage: ContactStorageProtocol {
    
    private var storageUserDefault = UserDefaults.standard // ссылка на хранилище
    private var KeyStorageUserDefault = "contacts" // ключ по которому будет происходить сохранение
    
    private enum ContactKey: String {
        case title
        case phone
    }
    
    func save(contacts: [ContactProtocol]) {
        var arrayForStorage: [[String : String]] = []
        contacts.forEach { contacts in
            var newElementForStorage: [String : String] = [:]
            newElementForStorage[ContactKey.title.rawValue] = contacts.title
            //print("c rawValue \(ContactKey.title.rawValue)")
            //print("без rawValue \(ContactKey.title)")
            newElementForStorage[ContactKey.phone.rawValue] = contacts.phone
            //print("save newElementForStorage title \(newElementForStorage)") // newElementForStorage имеет вид = ["title": "Den", "phone": "+79996385190"]

            arrayForStorage.append(newElementForStorage)
            //print("save arrayForStorage \(arrayForStorage)")

        }
        storageUserDefault.set(arrayForStorage, forKey: KeyStorageUserDefault)
    }
    
    func load() -> [ContactProtocol] {
        var resultContacts: [ContactProtocol] = []
        let contactFromStorage = storageUserDefault.array(forKey: KeyStorageUserDefault)
                                as? [[String : String]] ?? []
        
        for contact in contactFromStorage {
            guard let title = contact[ContactKey.title.rawValue],
                  let phone = contact[ContactKey.phone.rawValue]
            else {
                continue
            }
            resultContacts.append(Contact(title: title, phone: phone))
        }
        return resultContacts
    }
    
    
}
