//
//  RegisterInteractor.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import Foundation
import Firebase

class RegisterInteractor: PresenterToInteractorRegisterProtocol {
    var registerPresenter: InteractorToPresenterRegisterProtocol?
    var ref = Database.database().reference()
    
    func registerToFirebase(userName: String, userEmail: String, userPassword: String) {
        let myQuery = ref.child("Users").queryOrdered(byChild: "userName").queryEqual(toValue: userName)
        myQuery.observe(.value, with: { snapshot in
            let isDataNil = snapshot.value as? [String : AnyObject]
            if isDataNil == nil {
                let registerDict: [String : Any] = ["userName": userName, "userEmail": userEmail, "userPhone": "", "userCountry": "", "userPassword": userPassword]
                self.ref.child("Users").childByAutoId().setValue(registerDict)
                self.registerPresenter?.sendDataToPresenter(bool: true)
            }else{
                if let allData = isDataNil {
                    for myData in allData {
                        if let dict = myData.value as? NSDictionary {
                            if dict["userName"] as? String == userName {
                                self.registerPresenter?.sendDataToPresenter(bool: false)
                            }
                        }
                    }
                }
            }
        })
    }
}
