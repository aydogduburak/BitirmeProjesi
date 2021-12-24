//
//  CartInteractor.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 9.12.2021.
//

import Foundation
import Alamofire

class CartInteractor: PresenterToInteractorCartProtocol {
    var cartPresenter: InteractorToPresenterCartProtocol?
    
    func getAllProducts(userName: String) {
        let params: Parameters = ["kullanici_adi": userName]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).responseJSON{response in
            if let data = response.data {
                do{
                    var productList  = [CartYemekler]()
                    let myResponse = try JSONDecoder().decode(CartYemeklerCevap.self, from: data)
                    if let responseList = myResponse.sepet_yemekler {
                        productList = responseList
                    }
                    self.cartPresenter?.sendDataToPresenter(productsList: productList)
                }catch{
                    let productList = [CartYemekler]()
                    self.cartPresenter?.sendDataToPresenter(productsList: productList)
//                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func deleteSelectedProduct(productID: Int, userName: String) {
        let params: Parameters = ["sepet_yemek_id": productID, "kullanici_adi": userName]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).responseJSON{ response in
            if let data = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                        print(json)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        getAllProducts(userName: userName)
    }
    
    func deleteAllProducts(productsList: Array<Int>, userName: String) {
        for productID in productsList {
            let params: Parameters = ["sepet_yemek_id": productID, "kullanici_adi": userName]
            AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).responseJSON{ response in
                if let data = response.data {
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                            print(json)
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
