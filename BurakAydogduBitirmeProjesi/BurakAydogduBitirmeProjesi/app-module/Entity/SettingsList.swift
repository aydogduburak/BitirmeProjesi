//
//  SettingsList.swift
//  BurakAydogduBitirmeProjesi
//
//  Created by Burak Aydoğdu on 13.12.2021.
//

import Foundation

class SettingsList {
    var cellIcon: String?
    var cellTitle: String?
    var cellExplanation: String?
    
    init() {
    }
    
    init(cellIcon: String, cellTitle: String, cellExplanation: String) {
        self.cellIcon = cellIcon
        self.cellTitle = cellTitle
        self.cellExplanation = cellExplanation
    }
}
