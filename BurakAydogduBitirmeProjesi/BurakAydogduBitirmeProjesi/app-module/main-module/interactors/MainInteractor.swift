//
//  MainInteractor.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import Foundation
import Alamofire

class MainInteractor: PresenterToInteractorMainProtocol {
    var mainPresenter: InteractorToPresenterMainProtocol?
    
    func getAllProducts() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).responseJSON{ response in
            if let data = response.data {
                do {
                    let myResponse = try JSONDecoder().decode(YemekCevap.self, from: data)
                    var productList  = [Yemekler]()
                    if let responseList = myResponse.yemekler {
                        productList = responseList
                    }
                    self.mainPresenter?.sendDataToPresenter(productList: productList)
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
