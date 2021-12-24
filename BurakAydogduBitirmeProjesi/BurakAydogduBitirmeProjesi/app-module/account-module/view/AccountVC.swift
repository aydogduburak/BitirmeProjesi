//
//  AccountVC.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 14.12.2021.
//

import UIKit

class AccountVC: UIViewController {
    @IBOutlet weak var viewChangePassword: UIView!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfCountry: UITextField!
    @IBOutlet weak var buttonUpdateOutlet: UIButton!
    @IBOutlet weak var buttonVCPOutlet: UIButton!
    @IBOutlet weak var tfCurrentPassword: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var buttonChangePassword: UIButton!
    
    var user: Users?
    var accountPresenterObject: ViewToPresenterAccountProtocol?
    var accountToLoginObject: AccountToLoginProtocol?
    
    var bgColor = UIColor(named: "bgColor")
    var tColor = UIColor(named: "tColor")
    var yellowColor = UIColor(named: "yellowColor")
    var blueColor = UIColor(named: "blueColor")
    var btnTintColor = UIColor(named: "btnTintColor")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        AccountRouter.createModule(ref: self)
        
        if let u = user {
            labelUsername.text = "@\(u.userName!)"
            tfPhone.text = "\(u.userPhone!)"
            tfEmail.text = "\(u.userEmail!)"
            tfCountry.text = "\(u.userCountry!)"
        }
        
        configurateButton()
    }
    
    func configurateButton() {
        buttonUpdateOutlet.tintColor = btnTintColor
        buttonUpdateOutlet.backgroundColor = yellowColor
        buttonUpdateOutlet.layer.cornerRadius = 8
        
        buttonVCPOutlet.tintColor = blueColor
        buttonVCPOutlet.backgroundColor = bgColor
        
        buttonChangePassword.tintColor = btnTintColor
        buttonChangePassword.backgroundColor = blueColor
        buttonChangePassword.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewChangePassword.isHidden = true
    }

    @IBAction func buttonDeleteAccount(_ sender: Any) {
        let alert = UIAlertController(title: "Delete", message: "Would you like to delete your account?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {action in}
        alert.addAction(cancelAction)
        let confirmAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.accountPresenterObject?.delete(userID: (self.user?.userID)!, userName: (self.user?.userName)!)
            self.accountToLoginObject?.deleteAccount()
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }
    
    @IBAction func buttonUpdate(_ sender: Any) {
        if let up = tfPhone.text, let ue = tfEmail.text, let uc = tfCountry.text {
            accountPresenterObject?.update(userID: (user?.userID)!, userPhone: up, userEmail: ue, userCountry: uc)
        }
    }
    
    @IBAction func buttonViewCP(_ sender: Any) {
        viewChangePassword.isHidden = false
    }
    
    @IBAction func buttonChangePassword(_ sender: Any) {
        if tfCurrentPassword.text == user?.userPassword {
            let np = tfNewPassword.text
            let cp = tfConfirmPassword.text
            if np == cp {
                accountPresenterObject?.change(userID: (user?.userID)!, userPassword: np!)
            }else{
                let alert = UIAlertController(title: "Change Password", message: "Your new passwords are not the same", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) {action in}
                alert.addAction(cancelAction)
                self.present(alert, animated: true)
            }
        }else{
            let alert = UIAlertController(title: "New Passwords", message: "Your password and the current password you typed does not match.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel) {action in}
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
    }
}
