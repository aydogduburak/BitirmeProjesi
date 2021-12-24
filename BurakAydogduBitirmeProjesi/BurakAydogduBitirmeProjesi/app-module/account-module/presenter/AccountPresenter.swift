//
//  AccountPresenter.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 14.12.2021.
//

import Foundation

class AccountPresenter: ViewToPresenterAccountProtocol{
    var accountInteractor: PresenterToInteractorAccountProtocol?
    
    func delete(userID: String, userName: String) {
        accountInteractor?.deleteUser(userID: userID, userName: userName)
    }
    
    func update(userID: String, userPhone: String, userEmail: String, userCountry: String) {
        accountInteractor?.updateUser(userID: userID, userPhone: userPhone, userEmail: userEmail, userCountry: userCountry)
    }
    
    func change(userID: String, userPassword: String) {
        accountInteractor?.changePassword(userID: userID, userPassword: userPassword)
    }
    
}
