//
//  ProductVC.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import UIKit
import Kingfisher

class ProductVC: UIViewController {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var addToCartOutlet: UIButton!
    @IBOutlet weak var buyNowOutlet: UIButton!
    @IBOutlet weak var quantityStepperOutlet: UIStepper!
    
    var productPresenterObject: ViewToPresenterProductProtocol?
    var product: Yemekler?
    var user: String?
    
    let tColor = UIColor(named: "tColor")
    let bgColor = UIColor(named: "bgColor")
    let yellowColor = UIColor(named: "yellowColor")
    let blueColor = UIColor(named: "blueColor")
    let btnTintColor = UIColor(named: "btnTintColor")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ProductRouter.createModule(ref: self)
        
        self.navigationItem.title = "Food&Drink"
        let apperance = UINavigationBarAppearance()
        apperance.titleTextAttributes = [.foregroundColor : blueColor!, NSAttributedString.Key.font : UIFont(name: "SourceSans3-BlackItalic", size: 30)!]
        view.backgroundColor = bgColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.standardAppearance = apperance
        navigationController?.navigationBar.compactAppearance = apperance
        
        if let p = product {
            productNameLabel.text = p.yemek_adi?.uppercased()
            priceLabel.text = "\(p.yemek_fiyat!) ₺"
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(p.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    self.productImageView.kf.setImage(with: url)
                }
            }
        }
        
        configurateButton()
    }
    
    func configurateButton() {
        addToCartOutlet.tintColor = btnTintColor
        addToCartOutlet.backgroundColor = blueColor
        
        buyNowOutlet.tintColor = UIColor(named: "btnBuyNow")
        buyNowOutlet.backgroundColor = bgColor
        buyNowOutlet.layer.borderColor = yellowColor?.cgColor
        buyNowOutlet.layer.borderWidth = 2
    }
    
    @IBAction func quantityStepper(_ sender: UIStepper) {
        quantityLabel.text = "Qty:  \(Int(sender.value))"
        var totalPrices: Int?
        if let p = product {
            totalPrices = Int(sender.value) * Int(p.yemek_fiyat!)!
        }
        priceLabel.text = "\(totalPrices!) ₺"
    }
    
    @IBAction func buttonCart(_ sender: Any) {
        if let p = product, let u = user {
            productPresenterObject?.add(product: p, qty: Int(quantityStepperOutlet.value), user: u)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonBuy(_ sender: Any) {
        if let p = product, let u = user {
            productPresenterObject?.add(product: p, qty: Int(quantityStepperOutlet.value), user: u)
            performSegue(withIdentifier: "productToCart", sender: u)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productToCart" {
            let user = sender as? String
            let toVC = segue.destination as! CartVC
            toVC.user = user
        }
    }
}
