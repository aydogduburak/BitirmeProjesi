//
//  MainRouter.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import Foundation

class MainRouter: PresenterToRouterMainProtocol {
    static func createModule(ref: MainVC) {
        let presenter: ViewToPresenterMainProtocol & InteractorToPresenterMainProtocol = MainPresenter()
        ref.mainPresenterObject = presenter
        ref.mainPresenterObject?.mainInteractor = MainInteractor()
        ref.mainPresenterObject?.mainView = ref
        ref.mainPresenterObject?.mainInteractor?.mainPresenter = presenter
    }
}
