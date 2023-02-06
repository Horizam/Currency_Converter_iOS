//
//  CountryCell.swift
//  Currency Converter
//
//  Created by Horizam on 26/01/2023.
//

import UIKit

class CountryCell: UITableViewCell {
    //MARK: - @IBOutlets
    @IBOutlet weak var imgFlag    : UIImageView!
    @IBOutlet weak var lblCountry : UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblAmount  : UILabel!
    //MARK: - Identifier
    static var identifier: String {return String(describing: self)}
    static var nib       : UINib{return UINib(nibName: identifier, bundle: nil)}

    
//MARK: - Defaults
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
