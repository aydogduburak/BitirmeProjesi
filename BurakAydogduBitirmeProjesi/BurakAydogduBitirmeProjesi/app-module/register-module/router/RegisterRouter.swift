//
//  RegisterRouter.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import Foundation

class RegisterRouter: PresenterToRouterRegisterProtocol {
    static func createModule(ref: RegisterVC) {
        let presenter: ViewToPresenterRegisterProtocol & InteractorToPresenterRegisterProtocol = RegisterPresenter()
        ref.registerPresenterObject = presenter
        ref.registerPresenterObject?.registerInteractor = RegisterInteractor()
        ref.registerPresenterObject?.registerView = ref
        ref.registerPresenterObject?.registerInteractor?.registerPresenter = presenter
    }
}
