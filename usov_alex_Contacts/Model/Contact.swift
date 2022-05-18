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

struct Contact: ContactProtocol {
    
    var title: String
    var phone: String
    
}
