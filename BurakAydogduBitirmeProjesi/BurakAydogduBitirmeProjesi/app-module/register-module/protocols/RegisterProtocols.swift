//
//  RegisterProtocols.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import Foundation

protocol ViewToPresenterRegisterProtocol{
    var registerInteractor: PresenterToInteractorRegisterProtocol? {get set}
    var registerView: PresenterToViewRegisterProtocol? {get set}
    func register(userName: String, userEmail: String, userPassword: String)
}

protocol PresenterToInteractorRegisterProtocol{
    var registerPresenter: InteractorToPresenterRegisterProtocol? {get set}
    func registerToFirebase(userName: String, userEmail: String, userPassword: String)
}

protocol InteractorToPresenterRegisterProtocol{
    func sendDataToPresenter(bool: Bool)
}

protocol PresenterToViewRegisterProtocol{
    func sendDataToView(bool: Bool)
}

protocol PresenterToRouterRegisterProtocol{
    static func createModule(ref: RegisterVC)
}
    
