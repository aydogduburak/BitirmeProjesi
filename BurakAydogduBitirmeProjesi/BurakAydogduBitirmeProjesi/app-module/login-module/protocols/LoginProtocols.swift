//
//  LoginProtocols.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import Foundation

protocol ViewToPresenterLoginProtocol {
    var loginInteractor: PresenterToInteractorLoginProtocol? {get set}
    var loginView: PresenterToViewLoginProtocol? {get set}
    func login(userName: String)
}

protocol PresenterToInteractorLoginProtocol {
    var loginPresenter: InteractorToPresenterLoginProtocol? {get set}
    func loginCheck(name: String)
}

protocol InteractorToPresenterLoginProtocol {
    func sendDataToPresenter(user: Users)
}

protocol PresenterToViewLoginProtocol {
    func sendDataToView(user: Users)
}

protocol PresenterToRouterLoginProtocol {
    static func createModule(ref: LoginVC)
}
