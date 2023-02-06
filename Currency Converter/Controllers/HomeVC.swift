//
//  ViewController.swift
//  Currency Converter
//
//  Created by Hamid on 23/01/2023.
//

import UIKit

class HomeVC: UIViewController {
//MARK: - IBOutelets
    @IBOutlet weak var btnStart: UIButton!
    
//MARK: - Veriables and Constants
    
//MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
//MARK: - @IBActions
    
    @IBAction func onTapStart(_ sender: UIButton) {
        let nextVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBar") as! CustomTabBar
        nextVc.modalPresentationStyle = .fullScreen
        self.present(nextVc, animated: true)
//        self.present(nextVc, animated: true)
        
    }

}
//MARK: - Custom Implementations

