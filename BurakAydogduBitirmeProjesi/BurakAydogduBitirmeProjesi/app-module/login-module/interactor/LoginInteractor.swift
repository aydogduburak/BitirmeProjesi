//
//  LoginInteractor.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import Foundation
import Firebase

class LoginInteractor: PresenterToInteractorLoginProtocol {
    var loginPresenter: InteractorToPresenterLoginProtocol?
    var ref = Database.database().reference()
    
    func loginCheck(name: String) {
        let myQuery = ref.child("Users").queryOrdered(byChild: "userName").queryEqual(toValue: name)
        myQuery.observe(.value, with: { snapshot in
            if let allData = snapshot.value as? [String : AnyObject] {
                for myData in allData {
                    if let dict = myData.value as? NSDictionary {
                        let user = Users(userID: myData.key, userName: dict["userName"] as? String ?? "", userEmail: dict["userEmail"] as? String ?? "", userPhone: dict["userPhone"] as? String ?? "", userCountry: dict["userCountry"] as? String ?? "", userPassword: dict["userPassword"] as? String ?? "")
                        self.loginPresenter?.sendDataToPresenter(user: user)
                    }
                }
            }else {
                let user = Users(userID: "", userName: "", userEmail: "", userPhone: "", userCountry: "", userPassword: "")
                self.loginPresenter?.sendDataToPresenter(user: user)
            }
        })
    }
}
