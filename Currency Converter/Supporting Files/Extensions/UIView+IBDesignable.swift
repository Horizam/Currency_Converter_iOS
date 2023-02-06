//
//  UIView+Extension.swift
//  Gotaps
//
//  Created by Muneeb on 06/10/2022.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

@IBDesignable
class PlaceHolderTextView: UITextView {
    
    @IBInspectable var placeholder: String = "" {
        didSet{
            updatePlaceHolder()
        }
    }
    
    @IBInspectable var placeholderColor: UIColor = UIColor.gray {
        didSet {
            updatePlaceHolder()
        }
    }
    
    private var originalTextColor = UIColor.darkText
    private var originalText: String = ""
    
    private func updatePlaceHolder() {
        
        if self.text == "" || self.text == placeholder  {
            
            self.text = placeholder
            self.textColor = placeholderColor
            if let color = self.textColor {
                
                self.originalTextColor = color
            }
            self.originalText = ""
        } else {
            self.textColor = self.originalTextColor
            self.originalText = self.text
        }
        
    }
    
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        self.text = self.originalText
        self.textColor = self.originalTextColor
        return result
    }
    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        updatePlaceHolder()
        
        return result
    }
}

extension UIView {
    public func addViewBorder(borderColor:CGColor,borderWith:CGFloat,borderCornerRadius:CGFloat){
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = borderCornerRadius
        
    }
}


extension UITextField {
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
    
}

extension UITextView {
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
    
}

extension UIViewController {
    
     func CurrencyValues(model:Currency_Data_Model) -> [Float] {
        
        var arrValues = [Float]()
        arrValues.append(model.AED ?? 0.0)
        arrValues.append(model.AFN ?? 0.0)
        arrValues.append(model.ALL ?? 0.0)
        arrValues.append(model.AMD ?? 0.0)
        arrValues.append(model.ANG ?? 0.0)
        arrValues.append(model.AOA ?? 0.0)
        arrValues.append(model.ARS ?? 0.0)
        arrValues.append(model.AUD ?? 0.0)
        arrValues.append(model.AWG ?? 0.0)
        arrValues.append(model.AZN ?? 0.0)
        arrValues.append(model.BAM ?? 0.0)
        arrValues.append(model.BBD ?? 0.0)
        arrValues.append(model.BDT ?? 0.0)
        arrValues.append(model.BGN ?? 0.0)
        arrValues.append(model.BHD ?? 0.0)
        arrValues.append(model.BIF ?? 0.0)
        arrValues.append(model.BMD ?? 0.0)
        arrValues.append(model.BND ?? 0.0)
        arrValues.append(model.BOB ?? 0.0)
        arrValues.append(model.BRL ?? 0.0)
        arrValues.append(model.BSD ?? 0.0)
        arrValues.append(model.BTC ?? 0.0)
        arrValues.append(model.BTN ?? 0.0)
        arrValues.append(model.BWP ?? 0.0)
        arrValues.append(model.BYN ?? 0.0)
        arrValues.append(model.BYR ?? 0.0)
        arrValues.append(model.BZD ?? 0.0)
        arrValues.append(model.CAD ?? 0.0)
        arrValues.append(model.CDF ?? 0.0)
        arrValues.append(model.CHF ?? 0.0)
        arrValues.append(model.CLF ?? 0.0)
        arrValues.append(model.CLP ?? 0.0)
        arrValues.append(model.CNY ?? 0.0)
        arrValues.append(model.COP ?? 0.0)
        arrValues.append(model.CRC ?? 0.0)
        arrValues.append(model.CUC ?? 0.0)
        arrValues.append(model.CUP ?? 0.0)
        arrValues.append(model.CVE ?? 0.0)
        arrValues.append(model.CZK ?? 0.0)
        arrValues.append(model.DJF ?? 0.0)
        arrValues.append(model.DKK ?? 0.0)
        arrValues.append(model.DOP ?? 0.0)
        arrValues.append(model.DZD ?? 0.0)
        arrValues.append(model.EGP ?? 0.0)
        arrValues.append(model.ERN ?? 0.0)
        arrValues.append(model.ETB ?? 0.0)
        arrValues.append(model.EUR ?? 0.0)
        arrValues.append(model.FJD ?? 0.0)
        arrValues.append(model.FKP ?? 0.0)
        arrValues.append(model.GBP ?? 0.0)
        arrValues.append(model.GEL ?? 0.0)
        arrValues.append(model.GGP ?? 0.0)
        arrValues.append(model.GHS ?? 0.0)
        arrValues.append(model.GIP ?? 0.0)
        arrValues.append(model.GMD ?? 0.0)
        arrValues.append(model.GNF ?? 0.0)
        arrValues.append(model.GTQ ?? 0.0)
        arrValues.append(model.GYD ?? 0.0)
        arrValues.append(model.HKD ?? 0.0)
        arrValues.append(model.HNL ?? 0.0)
        arrValues.append(model.HRK ?? 0.0)
        arrValues.append(model.HTG ?? 0.0)
        arrValues.append(model.HUF ?? 0.0)
        arrValues.append(model.IDR ?? 0.0)
        arrValues.append(model.ILS ?? 0.0)
        arrValues.append(model.IMP ?? 0.0)
        arrValues.append(model.INR ?? 0.0)
        arrValues.append(model.IQD ?? 0.0)
        arrValues.append(model.IRR ?? 0.0)
        arrValues.append(model.ISK ?? 0.0)
        arrValues.append(model.JEP ?? 0.0)
        arrValues.append(model.JMD ?? 0.0)
        arrValues.append(model.JOD ?? 0.0)
        arrValues.append(model.JPY ?? 0.0)
        arrValues.append(model.KES ?? 0.0)
        arrValues.append(model.KGS ?? 0.0)
        arrValues.append(model.KHR ?? 0.0)
        arrValues.append(model.KMF ?? 0.0)
        arrValues.append(model.KPW ?? 0.0)
        arrValues.append(model.KRW ?? 0.0)
        arrValues.append(model.KWD ?? 0.0)
        arrValues.append(model.KYD ?? 0.0)
        arrValues.append(model.KZT ?? 0.0)
        arrValues.append(model.LAK ?? 0.0)
        arrValues.append(model.LBP ?? 0.0)
        arrValues.append(model.LKR ?? 0.0)
        arrValues.append(model.LRD ?? 0.0)
        arrValues.append(model.LSL ?? 0.0)
        arrValues.append(model.LTL ?? 0.0)
        arrValues.append(model.LVL ?? 0.0)
        arrValues.append(model.LYD ?? 0.0)
        arrValues.append(model.MAD ?? 0.0)
        arrValues.append(model.MDL ?? 0.0)
        arrValues.append(model.MGA ?? 0.0)
        arrValues.append(model.MKD ?? 0.0)
        arrValues.append(model.MMK ?? 0.0)
        arrValues.append(model.MNT ?? 0.0)
        arrValues.append(model.MOP ?? 0.0)
        arrValues.append(model.MRO ?? 0.0)
        arrValues.append(model.MUR ?? 0.0)
        arrValues.append(model.MVR ?? 0.0)
        arrValues.append(model.MWK ?? 0.0)
        arrValues.append(model.MXN ?? 0.0)
        arrValues.append(model.MYR ?? 0.0)
        arrValues.append(model.MZN ?? 0.0)
        arrValues.append(model.NAD ?? 0.0)
        arrValues.append(model.NGN ?? 0.0)
        arrValues.append(model.NIO ?? 0.0)
        arrValues.append(model.NOK ?? 0.0)
        arrValues.append(model.NPR ?? 0.0)
        arrValues.append(model.NZD ?? 0.0)
        arrValues.append(model.OMR ?? 0.0)
        arrValues.append(model.PAB ?? 0.0)
        arrValues.append(model.PEN ?? 0.0)
        arrValues.append(model.PGK ?? 0.0)
        arrValues.append(model.PHP ?? 0.0)
        arrValues.append(model.PKR ?? 0.0)
        arrValues.append(model.PLN ?? 0.0)
        arrValues.append(model.PYG ?? 0.0)
        arrValues.append(model.QAR ?? 0.0)
        arrValues.append(model.RON ?? 0.0)
        arrValues.append(model.RSD ?? 0.0)
        arrValues.append(model.RUB ?? 0.0)
        arrValues.append(model.RWF ?? 0.0)
        arrValues.append(model.SAR ?? 0.0)
        arrValues.append(model.SBD ?? 0.0)
        arrValues.append(model.SCR ?? 0.0)
        arrValues.append(model.SDG ?? 0.0)
        arrValues.append(model.SEK ?? 0.0)
        arrValues.append(model.SGD ?? 0.0)
        arrValues.append(model.SHP ?? 0.0)
        arrValues.append(model.SLE ?? 0.0)
        arrValues.append(model.SLL ?? 0.0)
        arrValues.append(model.SOS ?? 0.0)
        arrValues.append(model.SRD ?? 0.0)
        arrValues.append(model.STD ?? 0.0)
        arrValues.append(model.SVC ?? 0.0)
        arrValues.append(model.SYP ?? 0.0)
        arrValues.append(model.SZL ?? 0.0)
        arrValues.append(model.THB ?? 0.0)
        arrValues.append(model.TJS ?? 0.0)
        arrValues.append(model.TMT ?? 0.0)
        arrValues.append(model.TND ?? 0.0)
        arrValues.append(model.TOP ?? 0.0)
        arrValues.append(model.TRY ?? 0.0)
        arrValues.append(model.TTD ?? 0.0)
        arrValues.append(model.TWD ?? 0.0)
        arrValues.append(model.TZS ?? 0.0)
        arrValues.append(model.UAH ?? 0.0)
        arrValues.append(model.UGX ?? 0.0)
        arrValues.append(model.USD ?? 0.0)
        arrValues.append(model.UYU ?? 0.0)
        arrValues.append(model.UZS ?? 0.0)
        arrValues.append(model.VEF ?? 0.0)
        arrValues.append(model.VES ?? 0.0)
        arrValues.append(model.VND ?? 0.0)
        arrValues.append(model.VUV ?? 0.0)
        arrValues.append(model.WST ?? 0.0)
        arrValues.append(model.XAF ?? 0.0)
        arrValues.append(model.XAG ?? 0.0)
        arrValues.append(model.XAU ?? 0.0)
        arrValues.append(model.XCD ?? 0.0)
        arrValues.append(model.XDR ?? 0.0)
        arrValues.append(model.XOF ?? 0.0)
        arrValues.append(model.XPF ?? 0.0)
        arrValues.append(model.YER ?? 0.0)
        arrValues.append(model.ZAR ?? 0.0)
        arrValues.append(model.ZMK ?? 0.0)
        arrValues.append(model.ZMW ?? 0.0)
        arrValues.append(model.ZWL ?? 0.0)
       
        return arrValues
    }
    func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        alert.view.backgroundColor = UIColor(named: "green-dark")
        alert.view.tintColor = .white
        alert.view.alpha = 1
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    func showErrorToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        alert.view.backgroundColor = .red
        alert.view.tintColor = .white
        alert.view.alpha = 1
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
}

struct favourite {
    
    static  var arrFav  : [[String]] = []
    static var  arrIndx : [Int]      = []
    
    
}

