//
//  RegisterVC.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import UIKit

class RegisterVC: UIViewController {
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPasswordConfirm: UITextField!
    @IBOutlet weak var buttonRegisterOutlet: UIButton!
    
    var registerPresenterObject: ViewToPresenterRegisterProtocol?
    
    let tColor = UIColor(named: "tColor")
    let bgColor = UIColor(named: "bgColor")
    let blueColor = UIColor(named: "blueColor")
    let yellowColor = UIColor(named: "yellowColor")
    let btnTintColor = UIColor(named: "btnTintColor")

    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        RegisterRouter.createModule(ref: self)
        
        self.navigationItem.title = "Register"
        let apperance = UINavigationBarAppearance()
        apperance.titleTextAttributes = [.foregroundColor : blueColor!, NSAttributedString.Key.font : UIFont(name: "SourceSans3-BlackItalic", size: 30)!]
        view.backgroundColor = bgColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.standardAppearance = apperance
        navigationController?.navigationBar.compactAppearance = apperance
        
        configureTextFields()
        configureButton()
    }
    
    func configureTextFields(){
        var config = UIImage.SymbolConfiguration(paletteColors: [tColor!])
        config = config.applying(UIImage.SymbolConfiguration(weight: .bold))
        
        tfPassword.layer.borderColor = tColor?.cgColor
        tfPassword.layer.borderWidth = 2
        tfPassword.layer.cornerRadius = 10
        tfPassword.backgroundColor = bgColor
        
        tfPassword.leftViewMode = .always
        let passwordImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let passwordImage = UIImage(systemName: "key")
        passwordImageView.translatesAutoresizingMaskIntoConstraints = false
        passwordImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        passwordImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        passwordImageView.image = passwordImage
        passwordImageView.preferredSymbolConfiguration = config
        tfPassword.leftView = passwordImageView
        
        tfUsername.layer.borderColor = tColor?.cgColor
        tfUsername.layer.borderWidth = 2
        tfUsername.layer.cornerRadius = 10
        tfUsername.backgroundColor = bgColor
        
        tfUsername.leftViewMode = .always
        let userImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let userImage = UIImage(systemName: "person")
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        userImageView.image = userImage
        userImageView.preferredSymbolConfiguration = config
        tfUsername.leftView = userImageView
        
        tfEmail.layer.borderColor = tColor?.cgColor
        tfEmail.layer.borderWidth = 2
        tfEmail.layer.cornerRadius = 10
        tfEmail.backgroundColor = bgColor
        
        tfEmail.leftViewMode = .always
        let emailImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let emailImage = UIImage(systemName: "mail")?.withTintColor(tColor!)
        emailImageView.translatesAutoresizingMaskIntoConstraints = false
        emailImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        emailImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        emailImageView.image = emailImage
        emailImageView.preferredSymbolConfiguration = config
        tfEmail.leftView = emailImageView
        
        tfPasswordConfirm.layer.borderColor = tColor?.cgColor
        tfPasswordConfirm.layer.borderWidth = 2
        tfPasswordConfirm.layer.cornerRadius = 10
        tfPasswordConfirm.backgroundColor = bgColor
        
        tfPasswordConfirm.leftViewMode = .always
        let passwordCImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let passwordCImage = UIImage(systemName: "key.fill")
        passwordCImageView.translatesAutoresizingMaskIntoConstraints = false
        passwordCImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        passwordCImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        passwordCImageView.image = passwordCImage
        passwordCImageView.preferredSymbolConfiguration = config
        tfPasswordConfirm.leftView = passwordCImageView
    }
    
    func configureButton(){
        buttonRegisterOutlet.tintColor = btnTintColor
        buttonRegisterOutlet.backgroundColor = yellowColor
        buttonRegisterOutlet.layer.cornerRadius = 8
    }
    
    @IBAction func buttonRegister(_ sender: Any) {
        if tfPassword.text == tfPasswordConfirm.text{
            if let un = tfUsername.text, let ue = tfEmail.text, let up = tfPassword.text {
                registerPresenterObject?.register(userName: un, userEmail: ue, userPassword: up)
            }
        }else{
            let alert = UIAlertController(title: "Alert", message: "Passwords does not match.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {action in
                self.tfPassword.text = ""
                self.tfPasswordConfirm.text = ""
            }
            alert.addAction(cancelAction)
            present(alert, animated: true)
        }
    }
}

extension RegisterVC: PresenterToViewRegisterProtocol{
    func sendDataToView(bool: Bool){
        if bool{
            let alert = UIAlertController(title: "Sign Up", message: "You have successfully registered.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Done", style: .cancel) {action in
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.addAction(okAction)
            present(alert, animated: true)
        }else{
            let alert = UIAlertController(title: "Alert", message: "User already exists. Select a different username.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel) {action in}
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
}
