//
//  Kisiler.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import Foundation

class Users {
    var userID: String?
    var userName: String?
    var userEmail: String?
    var userPhone: String?
    var userCountry: String?
    var userPassword: String?
    
    init() {
    }
    
    init(userID: String, userName: String, userEmail: String, userPhone: String, userCountry: String, userPassword: String){
        self.userID = userID
        self.userName = userName
        self.userEmail = userEmail
        self.userPhone = userPhone
        self.userCountry = userCountry
        self.userPassword = userPassword
    }
}
