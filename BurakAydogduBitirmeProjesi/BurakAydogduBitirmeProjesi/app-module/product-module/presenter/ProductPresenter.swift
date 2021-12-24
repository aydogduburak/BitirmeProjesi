//
//  ProductPresenter.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 9.12.2021.
//

import Foundation

class ProductPresenter: ViewToPresenterProductProtocol {
    var productInteractor: PresenterToInteractorProductProtocol?
    
    func add(product: Yemekler, qty: Int, user: String) {
        productInteractor?.addToCart(product: product, qty: qty, user: user)
    }
}
