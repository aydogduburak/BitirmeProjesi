//
//  ProductProtocols.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 9.12.2021.
//

import Foundation

protocol ViewToPresenterProductProtocol {
    var productInteractor: PresenterToInteractorProductProtocol? {get set}
    func add(product: Yemekler, qty: Int, user: String)
}

protocol PresenterToInteractorProductProtocol {
    func addToCart(product: Yemekler, qty: Int, user: String)
}

protocol PresenterToRouterProductProtocol {
    static func createModule(ref: ProductVC)
}
