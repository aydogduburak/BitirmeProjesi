//
//  AccountProtocols.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 14.12.2021.
//

import Foundation

protocol ViewToPresenterAccountProtocol{
    var accountInteractor: PresenterToInteractorAccountProtocol? {get set}
    func delete(userID: String, userName: String)
    func update(userID: String, userPhone: String, userEmail: String, userCountry: String)
    func change(userID: String, userPassword: String)
}

protocol PresenterToInteractorAccountProtocol{
    func deleteUser(userID: String, userName: String)
    func updateUser(userID: String, userPhone: String, userEmail: String, userCountry: String)
    func changePassword(userID: String, userPassword: String)
    
}

protocol PresenterToRouterAccountProtocol{
    static func createModule(ref: AccountVC)
}

protocol AccountToLoginProtocol{
    func deleteAccount()
}
