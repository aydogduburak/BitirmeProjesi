//
//  CartProtocols.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 9.12.2021.
//

import Foundation

protocol ViewToPresenterCartProtocol {
    var cartInteractor: PresenterToInteractorCartProtocol? {get set}
    var cartView: PresenterToViewCartProtocol? {get set}
    func getAllProducts(userName: String)
    func deleteSelected(productID: Int, userName: String)
    func deleteAll(productsList: Array<Int>, userName: String)
}

protocol PresenterToInteractorCartProtocol {
    var cartPresenter: InteractorToPresenterCartProtocol? {get set}
    func getAllProducts(userName: String)
    func deleteSelectedProduct(productID: Int, userName: String)
    func deleteAllProducts(productsList: Array<Int>, userName: String)
}

protocol InteractorToPresenterCartProtocol {
    func sendDataToPresenter(productsList: Array<CartYemekler>)
}

protocol PresenterToViewCartProtocol {
    func sendDataToView(productsList: Array<CartYemekler>)
}

protocol PresenterToRouterCartProtocol {
    static func createModule(ref: CartVC)
}
