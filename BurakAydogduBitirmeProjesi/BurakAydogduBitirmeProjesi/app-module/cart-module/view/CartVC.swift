//
//  CartVC.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import UIKit

class CartVC: UIViewController {
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var cartSearchBar: UISearchBar!
    @IBOutlet weak var tfDiscount: UITextField!
    @IBOutlet weak var buttonAddCoupon: UIButton!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var buttonClearCartOutlet: UIButton!
    @IBOutlet weak var buttonBuyOutlet: UIButton!
    @IBOutlet weak var scrollViewPayment: UIScrollView!
    
    var user: String?
    var cartProductList = [CartYemekler]()
    var filteredProductList = [CartYemekler]()
    var cartPresenterObject: ViewToPresenterCartProtocol?
    var totalPrice: Int?
    
    let tColor = UIColor(named: "tColor")
    let bgColor = UIColor(named: "bgColor")
    let blueColor = UIColor(named: "blueColor")
    let yellowColor = UIColor(named: "yellowColor")
    let btnTintColor = UIColor(named: "btnTintColor")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CartRouter.createModule(ref: self)
        cartTableView.delegate  = self
        cartTableView.dataSource  = self
        cartSearchBar.delegate = self
        
        cartTableView.backgroundColor = bgColor
        
        self.navigationItem.title = "Cart"
        let apperance = UINavigationBarAppearance()
        apperance.titleTextAttributes = [.foregroundColor : blueColor!, NSAttributedString.Key.font : UIFont(name: "SourceSans3-BlackItalic", size: 30)!]
        view.backgroundColor = bgColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.standardAppearance = apperance
        navigationController?.navigationBar.compactAppearance = apperance
        
        configureButtons()
        configureTextField()
        
        scrollViewPayment.isHidden = true
    }
    
    func configureTextField() {
        tfDiscount.layer.borderWidth = 2
        tfDiscount.layer.borderColor = tColor?.cgColor
        tfDiscount.layer.cornerRadius = 8
    }
    
    func configureButtons() {
        buttonBuyOutlet.tintColor = btnTintColor
        buttonBuyOutlet.backgroundColor = blueColor
        
        buttonClearCartOutlet.tintColor = bgColor
        buttonClearCartOutlet.backgroundColor = tColor
        
        buttonAddCoupon.backgroundColor = yellowColor
        buttonAddCoupon.tintColor = btnTintColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartPresenterObject?.getAllProducts(userName: user!)
    }
    
    @IBAction func buttonToMain(_ sender: Any) {
        let vc =  self.navigationController?.viewControllers.filter({$0 is MainVC}).first
        //let vc = self.navigationController?.viewControllers[1]
        navigationController?.popToViewController(vc!, animated: true)
    }
    
    @IBAction func buttonAddCoupon(_ sender: Any) {
        if tfDiscount.text == "techcareer.net" {
            let discount: Float = Float(totalPrice!) * 0.75
            labelPrice.text = "\(discount) ₺"
            labelPrice.textColor = UIColor.systemGreen
        }
    }
    
    
    @IBAction func buttonClearCart(_ sender: Any) {
        let alert = UIAlertController(title: "Clear Cart", message: "Would you like to clear the cart?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {action in}
        alert.addAction(cancelAction)
        let confirmAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            var productsID = [Int]()
            for p in self.cartProductList {
                productsID.append(Int(p.sepet_yemek_id!)!)
            }
            self.cartPresenterObject?.deleteAll(productsList: productsID, userName: self.user!)
            let vc =  self.navigationController?.viewControllers.filter({$0 is MainVC}).first
            self.navigationController?.popToViewController(vc!, animated: true)
        }
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
    
    @IBAction func buttonBuy(_ sender: Any) {
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = filteredProductList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        cell.backgroundColor = UIColor(named: "bgColor")
        cell.setData(product: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let product = filteredProductList[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { (contexualAction, view, bool) in
            let product = self.filteredProductList[indexPath.row]
            let alert = UIAlertController(title: "Delete", message: "Would you like to delete \(product.yemek_adi!) from your cart?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {action in}
            alert.addAction(cancelAction)
            let confirmAction = UIAlertAction(title: "Delete", style: .destructive) { action in
                self.cartPresenterObject?.deleteSelected(productID: Int(product.sepet_yemek_id!)!, userName: self.user!)
            }
            alert.addAction(confirmAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension CartVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredProductList = []
        if searchText.isEmpty {
            filteredProductList = self.cartProductList
        }
        for product in cartProductList {
            guard let productName = product.yemek_adi else {return}
            if productName.lowercased().contains(searchText.lowercased()) {
                filteredProductList.append(product)
            }
        }
        cartTableView.reloadData()
    }
}

extension CartVC: PresenterToViewCartProtocol {
    func sendDataToView(productsList: Array<CartYemekler>) {
        self.cartProductList = productsList
        self.filteredProductList = productsList
        
        if !productsList.isEmpty {
            scrollViewPayment.isHidden = false
        }
        
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
        
        totalPrice = 0
        for p in productsList {
            totalPrice! += Int(p.yemek_fiyat!)! * Int(p.yemek_siparis_adet!)!
        }
        labelPrice.text = "\(totalPrice!) ₺"
    }
}
