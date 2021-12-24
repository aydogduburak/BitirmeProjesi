//
//  RegisterPresenter.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import Foundation

class RegisterPresenter: ViewToPresenterRegisterProtocol {
    var registerInteractor: PresenterToInteractorRegisterProtocol?
    var registerView: PresenterToViewRegisterProtocol?
    
    func register(userName: String, userEmail: String, userPassword: String) {
        registerInteractor?.registerToFirebase(userName: userName, userEmail: userEmail, userPassword: userPassword)
    }
}

extension RegisterPresenter: InteractorToPresenterRegisterProtocol{
    func sendDataToPresenter(bool: Bool) {
        registerView?.sendDataToView(bool: bool)
    }
}
