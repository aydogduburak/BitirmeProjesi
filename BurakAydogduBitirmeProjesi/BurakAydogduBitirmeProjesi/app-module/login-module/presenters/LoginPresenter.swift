//
//  LoginPresenter.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import Foundation

class LoginPresenter: ViewToPresenterLoginProtocol {
    var loginInteractor: PresenterToInteractorLoginProtocol?
    var loginView: PresenterToViewLoginProtocol?
    
    func login(userName: String) {
        loginInteractor?.loginCheck(name: userName)
    }
}

extension LoginPresenter: InteractorToPresenterLoginProtocol {
    func sendDataToPresenter(user: Users) {
        loginView?.sendDataToView(user: user)
    }
}
