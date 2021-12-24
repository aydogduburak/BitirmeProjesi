//
//  AccountInteractor.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 14.12.2021.
//

import Foundation
import Firebase
import Alamofire

class AccountInteractor: PresenterToInteractorAccountProtocol{
    var ref = Database.database().reference()
    
    func updateUser(userID: String, userPhone: String, userEmail: String, userCountry: String) {
        ref.child("Users").child(userID).updateChildValues(["userPhone": userPhone, "userEmail": userEmail, "userCountry": userCountry])
    }
    
    func changePassword(userID: String, userPassword: String) {
        ref.child("Users").child(userID).updateChildValues(["userPassword": userPassword])
    }
    
    func deleteUser(userID: String, userName: String) {
        let params: Parameters = ["kullanici_adi": userName]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).responseJSON{response in
            if let data = response.data {
                do{
                    var productList  = [CartYemekler]()
                    let myResponse = try JSONDecoder().decode(CartYemeklerCevap.self, from: data)
                    if let responseList = myResponse.sepet_yemekler {
                        productList = responseList
                    }
                    for p in productList {
                        let paramsID: Parameters = ["sepet_yemek_id": p.sepet_yemek_id!, "kullanici_adi": userName]
                        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: paramsID).responseJSON{ response in
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
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
        ref.child("Users").child(userID).removeValue()
    }
}
