//
//  ProductInteractor.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 9.12.2021.
//

import Foundation
import Alamofire

class ProductInteractor: PresenterToInteractorProductProtocol {
    func addToCart(product: Yemekler, qty : Int, user: String) {
        let params : Parameters = ["yemek_adi": product.yemek_adi!, "yemek_resim_adi": product.yemek_resim_adi!, "yemek_fiyat": Int(product.yemek_fiyat!)!, "yemek_siparis_adet": qty, "kullanici_adi": user]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).responseJSON{ response in
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
