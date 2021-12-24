//
//  CartTableViewCell.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 9.12.2021.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQty: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(product: CartYemekler) {
        self.productName.text = product.yemek_adi
        self.productQty.text = "Qty:  \(product.yemek_siparis_adet!)"
        if Int(product.yemek_siparis_adet!)! > 1 {
            let totalPrice = Int(product.yemek_siparis_adet!)! * Int(product.yemek_fiyat!)!
            self.productPrice.text = "\(totalPrice) ₺"
        }else {
            self.productPrice.text = "\(product.yemek_fiyat!) ₺"
        }
        setImage(productImageName: product.yemek_resim_adi!)
    }
    
    func setImage(productImageName : String) {
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(productImageName)") {
            DispatchQueue.main.async {
                self.productImageView.kf.setImage(with: url)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
