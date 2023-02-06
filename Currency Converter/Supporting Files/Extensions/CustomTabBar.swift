//
//  CustomTabBar.swift
//  Currency Converter
//
//  Created by Hamid on 31/01/2023.
//

import Foundation
import UIKit

class GreenTabBar: UITabBar {
    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.green
    }
}

class CustomTabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 0

    }
}
