//
//  SettingsTableViewCell.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 13.12.2021.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var imageSetting: UIImageView!
    @IBOutlet weak var labelSettingTitle: UILabel!
    @IBOutlet weak var labelSettingExp: UILabel!
    
    let tColor = UIColor(named: "tColor")

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(settings: SettingsList) {
        var config = UIImage.SymbolConfiguration(paletteColors: [tColor!])
        config = config.applying(UIImage.SymbolConfiguration(weight: .semibold))
        imageSetting.image = UIImage(systemName: settings.cellIcon!)
        imageSetting.preferredSymbolConfiguration = config
        labelSettingTitle.text = settings.cellTitle
        labelSettingExp.text = settings.cellExplanation
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
