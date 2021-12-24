//
//  CartPresenter.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 9.12.2021.
//

import Foundation

class CartPresenter: ViewToPresenterCartProtocol {
    var cartInteractor: PresenterToInteractorCartProtocol?
    
    var cartView: PresenterToViewCartProtocol?
    
    func getAllProducts(userName: String) {
        cartInteractor?.getAllProducts(userName: userName)
    }
    
    func deleteSelected(productID: Int, userName: String) {
        cartInteractor?.deleteSelectedProduct(productID: productID, userName: userName)
    }
    
    func deleteAll(productsList: Array<Int>, userName: String) {
        cartInteractor?.deleteAllProducts(productsList: productsList, userName: userName)
    }
}

extension CartPresenter: InteractorToPresenterCartProtocol {
    func sendDataToPresenter(productsList: Array<CartYemekler>) {
        cartView?.sendDataToView(productsList: productsList)
    }
}
