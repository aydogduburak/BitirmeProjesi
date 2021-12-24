//
//  AccountRouter.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 14.12.2021.
//

import Foundation

class AccountRouter: PresenterToRouterAccountProtocol{
    static func createModule(ref: AccountVC) {
        ref.accountPresenterObject = AccountPresenter()
        ref.accountPresenterObject?.accountInteractor = AccountInteractor()
        ref.accountToLoginObject = LoginVC()
    }
}
