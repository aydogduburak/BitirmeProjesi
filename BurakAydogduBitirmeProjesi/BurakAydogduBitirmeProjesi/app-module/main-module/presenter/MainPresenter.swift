//
//  MainPresenter.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import Foundation

class MainPresenter: ViewToPresenterMainProtocol {
    var mainInteractor: PresenterToInteractorMainProtocol?
    var mainView: PresenterToViewMainProtocol?
    
    func getProducts() {
        mainInteractor?.getAllProducts()
    }
}

extension MainPresenter: InteractorToPresenterMainProtocol {
    func sendDataToPresenter(productList: Array<Yemekler>) {
        mainView?.sendDataToView(productList: productList)
    }
    
    
}
