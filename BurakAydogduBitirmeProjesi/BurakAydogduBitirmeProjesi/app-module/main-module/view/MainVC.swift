//
//  MainVC.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import UIKit

class MainVC: UIViewController {    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productTableView: UITableView!
    
    var user: Users?
    var userDefaultsObject: MainToLoginProtocol?
    var producstArray = [Yemekler]()
    var mainPresenterObject: ViewToPresenterMainProtocol?
    var filteredProductList = [Yemekler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MainRouter.createModule(ref: self)
        searchBar.delegate = self
        productTableView.delegate = self
        productTableView.dataSource = self
        
        let bgColor = UIColor(named: "bgColor")
        let blueColor = UIColor(named: "blueColor")
        
        productTableView.backgroundColor = bgColor
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Food&Drink"
        let apperance = UINavigationBarAppearance()
        apperance.titleTextAttributes = [.foregroundColor : blueColor!, NSAttributedString.Key.font : UIFont(name: "SourceSans3-BlackItalic", size: 30)!]
        view.backgroundColor = bgColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.standardAppearance = apperance
        navigationController?.navigationBar.compactAppearance = apperance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainPresenterObject?.getProducts()
    }
    
    @IBAction func buttonLogout(_ sender: Any) {
        userDefaultsObject?.changeUserDefaults()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func buttonSettings(_ sender: Any) {
        performSegue(withIdentifier: "toSettings", sender: user)
    }
    
    @IBAction func buttonCart(_ sender: Any) {
        if let u = user{
            performSegue(withIdentifier: "toCart", sender: u.userName)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProduct" {
            if let s = sender as? Array<Any> {
                let product = s[0] as? Yemekler
                let user = s[1] as? Users
                let toVC = segue.destination as! ProductVC
                toVC.product = product
                toVC.user = user?.userName
            }
        }
        
        if segue.identifier == "toSettings" {
            let user = sender as? Users
            let toVC = segue.destination as! SettingsVC
            toVC.user = user
        }
        
        if segue.identifier == "toCart" {
            let user = sender as? String
            let toVC = segue.destination as! CartVC
            toVC.user = user
        }
    }
}

extension MainVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = filteredProductList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        cell.backgroundColor = UIColor(named: "bgColor")
        cell.setData(product: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = filteredProductList[indexPath.row]
        performSegue(withIdentifier: "toProduct", sender: [product, user!])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredProductList = []
        if searchText.isEmpty {
            filteredProductList = self.producstArray
        }
        for product in producstArray {
            guard let productName = product.yemek_adi else {return}
            if productName.lowercased().contains(searchText.lowercased()) {
                filteredProductList.append(product)
            }
        }
        productTableView.reloadData()
    }
}

extension MainVC : PresenterToViewMainProtocol {
    func sendDataToView(productList: Array<Yemekler>) {
        self.producstArray = productList
        self.filteredProductList = productList
        DispatchQueue.main.async {
            self.productTableView.reloadData()
        }
    }
}
