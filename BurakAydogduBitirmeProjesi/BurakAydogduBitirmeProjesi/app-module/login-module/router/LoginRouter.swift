//
//  LoginRouter.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import Foundation

class LoginRouter: PresenterToRouterLoginProtocol {
    static func createModule(ref: LoginVC) {
        let presenter: ViewToPresenterLoginProtocol & InteractorToPresenterLoginProtocol = LoginPresenter()
        
        ref.loginPresenterObject = presenter
        
        ref.loginPresenterObject?.loginInteractor = LoginInteractor()
        ref.loginPresenterObject?.loginView = ref
        
        ref.loginPresenterObject?.loginInteractor?.loginPresenter = presenter
    }
}
