//
//  CountryVC.swift
//  Currency Converter
//
//  Created by Hamid on 26/01/2023.
//

import UIKit
import GoogleMobileAds
protocol BaseCurrencyDelegate {
    func didSelectCountry(cntryNm: String , crncyNm: String)
}
class CountryVC: UIViewController {
//MARK: - IBOutelets
    
    @IBOutlet weak var tblvCountries: UITableView!
    @IBOutlet weak var searchCountry: SearchBar!
//MARK: - Veriables and Constants
    var baseCurrencyNames : [String] = []
    var baseCountryNames : [String] = []
    var filteredCountry : [String] = []
    var filteredCurrency : [String] = []
    var country : String = ""
    var isFromCountryVC: Bool = false
    var isFromFavourites: Bool = false
    var isSearching: Bool = false
    var delegate :BaseCurrencyDelegate? = nil
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(300))
        adBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adBannerView.delegate = self
        adBannerView.rootViewController = self

        return adBannerView
    }()
        
//MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar ()
        setSearchBar()
        setTableView ()
        setAd()
    }
//MARK: - @IBActions

}
//MARK: - Custom Implementations
extension CountryVC {
    
    func setUpNavigationBar () {
        self.navigationController?.navigationBar.topItem?.title = "Currency Converter"
        self.navigationController?.navigationBar.tintColor = UIColor(named:"green-dark")
        self.navigationController?.navigationBar.barTintColor = UIColor(named:"green-mid")
    }
    
    func setTableView () {
        tblvCountries.delegate = self
        tblvCountries.dataSource = self
        tblvCountries.register(CountryCell.nib, forCellReuseIdentifier: CountryCell.identifier)
        tblvCountries.register(adCell.nib, forCellReuseIdentifier: adCell.idenitifier)
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

//MARK: - SearchBar delegate methods
extension CountryVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredCountry = baseCountryNames.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        filteredCurrency = baseCurrencyNames.filter { (item: String) -> Bool in
            return baseCountryNames[baseCurrencyNames.firstIndex(of: item)!].range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        if searchText.isEmpty == true {
            filteredCountry = baseCountryNames
            filteredCurrency = baseCurrencyNames
        }
        self.tblvCountries.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" || searchBar.text == nil {
            searchBar.setShowsCancelButton(false, animated: true)
            isSearching = false
            tblvCountries.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        isSearching = false
        tblvCountries.reloadData()
        searchBar.resignFirstResponder()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
         
    }
    
}

//MARK: - UITableView Delegate Methods
extension CountryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredCountry.count
        } else {
            return baseCountryNames.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier) as! CountryCell
        if isFromFavourites == true || isFromCountryVC == true{
            if isSearching == true {
                let countryName = isSearching ? filteredCountry[indexPath.row] : baseCountryNames[indexPath.row]
                let currencyName = baseCurrencyNames[baseCountryNames.firstIndex(of: countryName)!]
                cell.lblCountry.text = countryName
                cell.lblCurrency.text = currencyName
                
            } else {
                cell.lblCountry.text = baseCountryNames[indexPath.row]
                cell.lblCurrency.text = baseCurrencyNames[indexPath.row]
            }
            cell.lblAmount.isHidden = true
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching == true {
            delegate?.didSelectCountry(cntryNm: filteredCountry[indexPath.row], crncyNm: filteredCurrency[indexPath.row])
        } else {
            delegate?.didSelectCountry(cntryNm: baseCountryNames[indexPath.row], crncyNm: baseCurrencyNames[indexPath.row])
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

//MARK: - GADBannerView Delegate
extension CountryVC: GADBannerViewDelegate {
    
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

