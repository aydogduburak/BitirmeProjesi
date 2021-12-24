//
//  ProductTableViewCell.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 8.12.2021.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(product: Yemekler){
        foodNameLabel.text = product.yemek_adi
        foodPriceLabel.text = "\(product.yemek_fiyat!) ₺"
        setImage(productImageName: product.yemek_resim_adi!)
    }
    
    func setImage(productImageName: String) {
        if let url = URL(string : "http://kasimadalan.pe.hu/yemekler/resimler/\(productImageName)") {
            DispatchQueue.main.async {
                self.foodImageView.kf.setImage(with: url)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
