//
//  MainProtocol.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import Foundation

protocol ViewToPresenterMainProtocol {
    var mainInteractor: PresenterToInteractorMainProtocol? {get set}
    var mainView: PresenterToViewMainProtocol? {get set}
    
    func getProducts()
}

protocol PresenterToInteractorMainProtocol {
    var mainPresenter: InteractorToPresenterMainProtocol? {get set}
    
    func getAllProducts()
}

protocol InteractorToPresenterMainProtocol {
    func sendDataToPresenter(productList: Array<Yemekler>)
}

protocol PresenterToViewMainProtocol {
    func sendDataToView(productList: Array<Yemekler>)
}

protocol PresenterToRouterMainProtocol {
    static func createModule(ref: MainVC)
}

protocol MainToLoginProtocol {
    func changeUserDefaults()
}
