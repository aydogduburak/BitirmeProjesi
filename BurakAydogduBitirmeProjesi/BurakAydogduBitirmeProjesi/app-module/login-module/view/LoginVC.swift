//
//  ViewController.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var buttonLoginOutlet: UIButton!
    @IBOutlet weak var buttonAccountOutlet: UIButton!
    @IBOutlet weak var imageAppIcon: UIImageView!
    
    var user: Users?
    var loginPresenterObject: ViewToPresenterLoginProtocol?
    let ud = UserDefaults.standard

    let tColor = UIColor(named: "tColor")
    let bgColor = UIColor(named: "bgColor")
    let blueColor = UIColor(named: "blueColor")
    let yellowColor = UIColor(named: "yellowColor")
    let btnTintColor = UIColor(named: "btnTintColor")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LoginRouter.createModule(ref: self)
        
        imageAppIcon.image = UIImage(named: "myIcon")
        imageAppIcon.layer.cornerRadius = 16
        
        navigationController?.navigationBar.tintColor = blueColor

        self.navigationItem.title = "Food&Drink"
        let apperance = UINavigationBarAppearance()
        apperance.titleTextAttributes = [.foregroundColor: blueColor!, NSAttributedString.Key.font: UIFont(name: "SourceSans3-BlackItalic", size: 30)!]
        view.backgroundColor = bgColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.standardAppearance = apperance
        navigationController?.navigationBar.compactAppearance = apperance
        
        configureTextFields()
        configureButtons()
        
        if ud.bool(forKey: "isLogin") {
            print("isLogin çalıştı.")
            loginPresenterObject?.login(userName: ud.string(forKey: "userName")!)
        }
    }
    
    func configureTextFields(){
        var config = UIImage.SymbolConfiguration(paletteColors: [tColor!])
        config = config.applying(UIImage.SymbolConfiguration(weight: .bold))
        
        tfUsername.layer.borderColor = tColor?.cgColor
        tfUsername.layer.borderWidth = 2
        tfUsername.layer.cornerRadius = 8
        tfUsername.attributedPlaceholder = NSAttributedString(string: "Username")
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
        
        tfPassword.leftViewMode = .always
        let passwordImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let passwordImage = UIImage(systemName: "key")
        passwordImageView.translatesAutoresizingMaskIntoConstraints = false
        passwordImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        passwordImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        passwordImageView.image = passwordImage
        passwordImageView.preferredSymbolConfiguration = config
        tfPassword.leftView = passwordImageView
        
        tfPassword.layer.borderColor = tColor?.cgColor
        tfPassword.layer.borderWidth = 2
        tfPassword.layer.cornerRadius = 8
        tfPassword.attributedPlaceholder = NSAttributedString(string: "Password")
        tfPassword.backgroundColor = bgColor
        }
    
    func configureButtons() {
        buttonLoginOutlet.tintColor = btnTintColor
        buttonLoginOutlet.layer.cornerRadius = 8
        buttonLoginOutlet.backgroundColor = blueColor
        
        buttonAccountOutlet.tintColor = btnTintColor
        buttonAccountOutlet.layer.cornerRadius = 8
        buttonAccountOutlet.backgroundColor = yellowColor
    }
    
    @IBAction func buttonLogin(_ sender: Any) {
        if let un = tfUsername.text, let _ = tfPassword.text {
            loginPresenterObject?.login(userName: un)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMain" {
            let user = sender as? Users
            let toVC = segue.destination as! MainVC
            toVC.user = user
            toVC.userDefaultsObject = self
        }
    }
}

extension LoginVC: PresenterToViewLoginProtocol {
    func sendDataToView(user: Users) {
        if user.userName == ""{
            let alert = UIAlertController(title: "Alert", message: "User does not exists.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel) {action in}
            alert.addAction(okAction)
            present(alert, animated: true)
        }else{
            self.user = user
            if ud.bool(forKey: "isLogin") == false {
                if user.userPassword == tfPassword.text {
                    ud.set(true, forKey: "isLogin")
                    ud.set(user.userName, forKey: "userName")
                    performSegue(withIdentifier: "toMain", sender: user)
                    tfUsername.text = ""
                    tfPassword.text = ""
                }else {
                    let alert = UIAlertController(title: "Alert", message: "User and password does not match.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .cancel) {action in}
                    alert.addAction(okAction)
                    present(alert, animated: true)
                }
            }else {
                performSegue(withIdentifier: "toMain", sender: user)
            }
        }
    }
}

extension LoginVC: MainToLoginProtocol{
    func changeUserDefaults() {
        ud.set(nil, forKey: "userName")
        ud.set(false, forKey: "isLogin")
    }
}

extension LoginVC: AccountToLoginProtocol{
    func deleteAccount() {
        ud.set(nil, forKey: "userName")
        ud.set(false, forKey: "isLogin")
    }
}
