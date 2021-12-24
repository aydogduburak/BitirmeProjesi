//
//  CartRouter.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 9.12.2021.
//

import Foundation

class CartRouter: PresenterToRouterCartProtocol {
    static func createModule(ref: CartVC) {
        let presenter: ViewToPresenterCartProtocol & InteractorToPresenterCartProtocol = CartPresenter()
        ref.cartPresenterObject = presenter
        ref.cartPresenterObject?.cartInteractor = CartInteractor()
        ref.cartPresenterObject?.cartView = ref
        ref.cartPresenterObject?.cartInteractor?.cartPresenter = presenter
    }
}
