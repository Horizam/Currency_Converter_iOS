//
//  adCell.swift
//  Currency Converter
//
//  Created by Horizam on 02/02/2023.
//

import UIKit
class adCell: UITableViewCell {
    //MARK: - @IBOutlets
    
    
    //MARK: - Identifier
    static var idenitifier: String{return String(describing: self)}
    static var nib: UINib{return UINib(nibName: idenitifier, bundle: nil)}
    //MARK: - Defaults
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

