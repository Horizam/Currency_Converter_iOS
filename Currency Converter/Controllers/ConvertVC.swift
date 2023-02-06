//
//  ConvertVC.swift
//  Currency Converter
//
//  Created by Horizam on 26/01/2023.
//

import UIKit
import GoogleMobileAds
class ConvertVC: UIViewController {
    //MARK: - IBOutelets
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblSelectedCurrency: UILabel!
    @IBOutlet weak var lblSelectedCountry: UILabel!
    @IBOutlet weak var lblCurrencyC: UILabel!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var tblvCountries: UITableView!
    @IBOutlet weak var searchCountry: SearchBar!
    //MARK: - Veriables and Constants
    var currencies = Currency_Data_Model()
    var countryDelegate: BaseCurrencyDelegate? = nil
    var searchCountries: Bool = false
    var filteredCountryNames = [String]()
    var filteredCurrencyNames = [String]()
    var filteredAmounts = [Float]()
    var selectedIndexPath: IndexPath?
    var arrValues  = [Float]()
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(300))
        adBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adBannerView.delegate = self
        adBannerView.rootViewController = self

        return adBannerView
    }()
    let userDefaults = UserDefaults.standard
    var currencyNames : [String] = ["AED", "AFN","ALL", "AMD", "ANG", "AOA", "ARS", "AUD", "AWG", "AZN", "BAM", "BBD", "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BRL", "BSD", "BTC", "BTN", "BWP", "BYN", "BYR", "BZD", "CAD", "CDF", "CHF", "CLF", "CLP", "CNY", "COP", "CRC", "CUC", "CUP", "CVE", "CZK", "DJF", "DKK", "DOP", "DZD", "EGP", "ERN", "ETB", "EUR", "FJD", "FKP", "GBP", "GEL", "GGP", "GHS", "GIP", "GMD", "GNF", "GTQ", "GYD", "HKD", "HNL", "HRK", "HTG", "HUF", "IDR", "ILS", "IMP", "INR", "IQD", "IRR", "ISK", "JEP", "JMD", "JOP", "JPY", "KES", "KGS", "KHR", "KMF", "KPW", "KRW", "KWD", "KYD", "KZT", "LAK", "LBP", "LKR", "LRD", "LSL", "LTL", "LVL", "LYD", "MAD", "MDL", "MGA", "MKD", "MMK", "MNT", "MOP", "MRO", "MUR", "MVR", "MWK", "MXN", "MYR", "MZN", "NAD", "NGN", "NIO", "NOK", "NPR", "NZD", "OMR", "PAB", "PEN", "PGK", "PHP", "PKR", "PLN", "PYG", "QAR", "RON", "RSD", "RUB", "RWF", "SAR", "SBD", "SCR", "SDG", "SEK", "SGD", "SHP", "SLE", "SLL", "SOS", "SRD", "STD", "SVC", "SYP", "SZL", "THB", "TJS", "TMT", "TND", "TOP", "TRY", "TTD", "TWD", "TZS", "UAH", "UGX", "USD", "UYU", "UZS", "VEF", "VES", "VND","VUV", "WST", "XAF", "XAG", "XAU", "XCD", "XDR","XOF","XPF","YER","ZAR","ZMK","ZMW","ZWL"]
    
    var countryNames: [String] = ["United Arab Emirates","Afghanistan","ALL","Armenia","Sint Marteen","Angola","Argentina","Australia","aruba","azerbaijan","bosnia","barbados","bangladesh","bulgaria","bahrain","burundi","burmuda","brunei","bolivia","brazil","bahamas","bhutan","bhutan","botswana","belarus","Afghanistan","belize","Canada","Democratic Republic of the Congo","Switzerland"," Chile"," Chile","Albania","Colombia","Costa Rica"," Cuba"," Cuba","Cabo Verde","Czechia","Djibouti","Denmark,","Dominican Republic","Algeria","Egypt","Eritrea","Ethiopia","Lithuania","Fiji","Falkland Islands","United Kingdom","Georgia","Ghana","Ghana","Gibraltar ","Gambia","Guinea","Guatemala","Guyana","Hong Kong","Honduras","Albania","Haiti","Hungary","Indonesia","Israel","","India","Iraq","Iran","Iceland","Jamaica","Jamaica","","Japan","Kenya","Kyrgyzstan","Cambodia","Comoros","North Korea","South Korea","Kuwait","Cayman Islands","Kazakhstan","Laos","Lebanon","Sri Lanka","Liberia","Lesotho","","","Libya","Morocco","Moldova","Madagascar","North Macedonia","Myanmar","Mongolia","Macau","Mauritania","Mauritius","Maldives","Malawi","Mexico","Malaysia","Mozambique","Namibia ","Nigeria","Nicaragua","Norway","Nepal","New Zealand","Oman","Panama","Peru","Papua New Guinea","Philippines","Pakistan"," Poland","Paraguay","Qatar","Romania","Serbia","Russia","Rwanda","Saudi Arabia","Solomon Islands","Seychelles","Sudan","Sweden","Singapore","Ascension Island","Sierra Leone","Sierra Leone","Somalia","Suriname","South Sudan","El Salvador","Syria","Eswatini","Thailand","Tajikistan","Turkmenistan","Tunisia","Tonga","Turkey","Trinidad and Tobago","Taiwan","Tanzania","Ukraine","Uganda","United States","Uruguay",
        "Uzbekistan","","Venezuela","Vietnam","VUV","Samoa","Cameroon","Albania","Albania","Antigua and Barbuda ","International Monetary Fund","Senegal ","New Caledonia ","Yemen","South Africa","Albania","Zambia","Zimbabwe"]
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView ()
        setUpNavigationBar()
        setSearchBar()
        setAd()
    }
    
    //MARK: - @IBActions
    @IBAction func onTapCountry(_ sender: Any) {
        onTapBaseCurrency()
    }
    
    @IBAction func onTapConvert(_ sender: Any) {
        convertCurrency ()
    }
    
}
//MARK: - Custom Implementations
extension ConvertVC {
    
    func setUpNavigationBar() {
        self.navigationItem.title = "Currency Converter"
        self.navigationController?.navigationBar.tintColor = UIColor(named:"green-dark")
        self.navigationController?.navigationBar.barTintColor = UIColor(named:"green-mid")
        self.navigationController?.navigationBar.topItem?.title = "Currency Converter"
    }
    
    func setTableView () {
        tblvCountries.delegate = self
        tblvCountries.dataSource = self
        tblvCountries.register(CountryCell.nib, forCellReuseIdentifier: CountryCell.identifier)
    }
    
    func setSearchBar() {
        self.searchCountry.delegate = self
        self.searchCountry.cancelButtonColor = UIColor(named:"green-dark")
        self.searchCountry.clearButtonColor = UIColor(named:"green-dark")
        self.searchCountry.searchIconColor =  UIColor(named:"green-dark")
    }
    
    func setAd(){
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ GADSimulatorID ]
        adBannerView.load(GADRequest())
    }
    
}

//MARK: - SearchBar Delegate methods
extension ConvertVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredCountryNames = countryNames.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        filteredCurrencyNames = currencyNames.filter { (item: String) -> Bool in
            return countryNames[currencyNames.firstIndex(of: item)!].range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        filteredAmounts =  CurrencyValues(model: currencies).filter { (item: Float) -> Bool in
            return countryNames[CurrencyValues(model: currencies).firstIndex(of: item)!].range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        
        if searchText.isEmpty {
            filteredCountryNames = countryNames
            filteredCurrencyNames = currencyNames
            filteredAmounts = CurrencyValues(model: currencies)
        }
        self.tblvCountries.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchCountries = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" || searchBar.text == nil {
            searchBar.setShowsCancelButton(false, animated: true)
            searchCountries = false
            tblvCountries.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        searchCountries = false
        tblvCountries.reloadData()
        searchBar.resignFirstResponder()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
         
    }

}

//MARK: - UITableView Delegate Methods
extension ConvertVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchCountries == true {
            return filteredCountryNames.count
        } else {
            return currencyNames.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier) as! CountryCell
        
        if searchCountries {
            let countryName = searchCountries ? filteredCountryNames[indexPath.row] : countryNames[indexPath.row]
                let currencyCode = currencyNames[countryNames.firstIndex(of: countryName)!]
               let amount        = CurrencyValues(model: self.currencies)[countryNames.firstIndex(of: countryName)!]
            cell.lblCountry.text = countryName
            cell.lblCurrency.text = currencyCode
            cell.lblAmount.text = String(amount)
//            let roundedValue = Double(CurrencyValues(model: self.currencies)[indexPath.row])
//            cell.lblAmount.isHidden = true
//            let doubleStr = String(format: "%.2f", roundedValue) // "3.14"
//            cell.lblAmount.text = doubleStr

        }else {
            cell.lblCurrency.text = currencyNames[indexPath.row]
            cell.lblCountry.text = countryNames[indexPath.row]
            let value = Double(CurrencyValues(model: self.currencies)[indexPath.row])
            let doubleStr = String(format: "%.2f", value) // "3.14"
            cell.lblAmount.isHidden = false
            cell.lblAmount.text = doubleStr
            
        }
        if indexPath == selectedIndexPath {
            let value = Double(CurrencyValues(model: self.currencies)[indexPath.row])
            let doubleStr = String(format: "%.2f", value) // "3.14"
            lblAmount.text = doubleStr
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
        if searchCountries ==  true{
            self.lblSelectedCountry.text = filteredCountryNames[indexPath.row]
            self.lblSelectedCurrency.text = filteredCurrencyNames[indexPath.row]
            self.lblCurrencyC.text = filteredCurrencyNames[indexPath.row]
            
            if filteredAmounts.count  != 0 {
                self.lblAmount.text = String (filteredAmounts[indexPath.row])
            }
           

//            var value = Double(CurrencyValues(model: self.currencies)[indexPath.row])
//            let doubleStr = String(format: "%.2f", value) // "3.14"
//            self.lblAmount.text    = "\(filteredAmounts[indexPath.row])"
        }else{
            var value = Double(CurrencyValues(model: self.currencies)[indexPath.row])
            let doubleStr = String(format: "%.2f", value) // "3.14"
            self.lblAmount.text    = doubleStr
            self.lblCurrencyC.text = currencyNames[indexPath.row]
            self.lblSelectedCountry.text = countryNames[indexPath.row]
            self.lblSelectedCurrency.text = currencyNames[indexPath.row]
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swpGroup = UIContextualAction(style: .normal, title: "Add to Favourites") { [weak self] (action, view, completionHandler) in
            
            
            var value = Double(self!.CurrencyValues(model: self!.currencies)[indexPath.row])
            let doubleStr = String(format: "%.2f", value) // "3.14"
//
//            print(self!.favourite(currncy: self!.currencyNames[indexPath.row] , cntry: self!.countryNames[indexPath.row], amnt: doubleStr, flag: 1))
            
            favourite.arrFav.append([self!.currencyNames[indexPath.row] , self!.countryNames[indexPath.row] , doubleStr])
            favourite.arrIndx.append(indexPath.row)
            
            if UserDefault.Index.contains(indexPath.row) {
                self!.showErrorToast(message: "Already exist in favourites", seconds: 2.0)
                
            }
            else {
                
                let arr = [self!.currencyNames[indexPath.row] , self!.countryNames[indexPath.row]]
                UserDefault.Favourite.append( arr)
                UserDefault.Index.append( indexPath.row)
                self!.showToast(message: "Added to favourites", seconds: 2.0)
                print("INDEX:",UserDefault.Index)
                print("FAV:",UserDefault.Favourite)
            }
           
        
            
               completionHandler(true)
            
        }
        swpGroup.backgroundColor = UIColor(named: "green-mid")
        
        let configuration = UISwipeActionsConfiguration (actions: [swpGroup])
        return configuration
        
    }
    
    

    
    
    
}

//MARK: - GADBannerView Delegate
extension ConvertVC: GADBannerViewDelegate {
    
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            
                
                print("Banner loaded successfully")
                let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
                bannerView.transform = translateTransform
            
                UIView.animate(withDuration: 0.5) {
                    self.tblvCountries.tableHeaderView?.frame = bannerView.frame
                    bannerView.transform = CGAffineTransform.identity
                    self.tblvCountries.tableHeaderView = bannerView
                }
            
        }
        
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            
                print("Fail to receive ads")
                print(error.localizedDescription)
            
        }
    
}
//MARK: - API Calling
extension ConvertVC {
    
    func convertCurrency () {
        if txtAmount.text?.isEmpty == true {
            let alertController = UIAlertController(title: Constants.APP_NAME, message: "Please enter amount", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let amount = txtAmount.text ?? ""
        let baseCurrency = lblCurrency.text ?? ""
        
        
       
        
        RequestServices.shared.getData(endUrl:"?amount=\(amount)&base_currency=\(baseCurrency)" ) { response, error in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let data : Data = response as? Data {
                let decoder = JSONDecoder()
                do {
                    let countries = try decoder.decode(Currency_Main_Model.self, from: data)
                    self.currencies = countries.data
                    let doubleStr = String(format: "%.2f", Double(countries.data.USD ?? 0.0)) // "3.14"
                    self.lblAmount.text = doubleStr
                    self.tblvCountries.reloadData()
                    
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    func onTapBaseCurrency() {
        let nextVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountryVC") as! CountryVC
        
        nextVc.baseCountryNames  = self.countryNames
        nextVc.baseCurrencyNames = self.currencyNames
        nextVc.isFromCountryVC   = true
        nextVc.delegate          = self
        self.navigationController?.pushViewController(nextVc, animated: true)
    }
    
    

}
//MARK: - Delegates
extension ConvertVC: BaseCurrencyDelegate {
    
    func didSelectCountry(cntryNm: String, crncyNm: String) {
        
        self.lblCountry.text   = cntryNm
        self.lblCurrency.text  = crncyNm
        
    }
}
