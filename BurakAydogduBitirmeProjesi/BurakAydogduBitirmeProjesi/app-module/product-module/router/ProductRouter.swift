//
//  ProductRouter.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 9.12.2021.
//

import Foundation

class ProductRouter: PresenterToRouterProductProtocol {
    static func createModule(ref: ProductVC) {
        ref.productPresenterObject = ProductPresenter()
        ref.productPresenterObject?.productInteractor = ProductInteractor()
    }
}
