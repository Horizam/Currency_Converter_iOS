//
//  FavouritesVC.swift
//  Currency Converter
//
//  Created by Hamid on 31/01/2023.
//

import UIKit
import Alamofire
import GoogleMobileAds
class FavouritesVC: UIViewController {
    //MARK: - IBOutelets
    @IBOutlet weak var lblFCurrency: UILabel!
    @IBOutlet weak var lblFCountry: UILabel!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var tblVcountry: UITableView!
    
    //MARK: - Veriables and Constants
    var fCurrencyNames : [String] = []
    var fCountryNames  : [String] = []
    var fCell          : [UITableViewCell] = []
    var fAmount        : [String] = []
    var Cdata = ConvertVC()
    var fCountryDelegate: BaseCurrencyDelegate? = nil
    var currencies = Currency_Data_Model()
    var apiCalled: Bool = false
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
        
        setTableView()
        setAd()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblVcountry.reloadData()
    }
    //MARK: - @IBActions
    
    @IBAction func onTapCountry(_ sender: Any) {
        let nextVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountryVC") as! CountryVC
        nextVc.isFromFavourites = true
        nextVc.baseCountryNames = Cdata.countryNames
        nextVc.baseCurrencyNames = Cdata.currencyNames
        nextVc.delegate = self
        self.navigationController?.pushViewController(nextVc, animated: true)
    }
    @IBAction func onTapConvert(_ sender: Any) {
        convertCurrency ()
    }
    
}
//MARK: - Custom Implementations
extension FavouritesVC {
    
    func setTableView() {
        tblVcountry.delegate = self
        tblVcountry.dataSource = self
        tblVcountry.register(CountryCell.nib, forCellReuseIdentifier: CountryCell.identifier)
    }
    
    func getFavAmounts() {
        
        self.fAmount.removeAll()
        for i in 0..<UserDefault.Index.count {
            
            var value = Double(CurrencyValues(model: self.currencies)[UserDefault.Index[i]])
            let doubleStr = String(format: "%.2f", value) // "3.14"
            self.fAmount.append(doubleStr)
            
        }
        self.tblVcountry.reloadData()
    }
    
    func setAd(){
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ GADSimulatorID ]
        adBannerView.load(GADRequest())
    }
}
//MARK: - TableView Delegate methods
extension FavouritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefault.Favourite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier) as! CountryCell
        cell.lblCurrency.text = UserDefault.Favourite[indexPath.row][0]
        cell.lblCountry.text  = UserDefault.Favourite[indexPath.row][1]
        cell.lblAmount.isHidden = true
        if fAmount.count != 0 && fAmount.count == UserDefault.Favourite.count {
            
            cell.lblAmount.text   = "\(fAmount[indexPath.row])"
        }
        if apiCalled == true {
            cell.lblAmount.isHidden = false
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swpGroup = UIContextualAction(style: .normal, title: "Remove") { [weak self] (action, view, completionHandler) in
            
            
            UserDefault.Favourite.remove(at: indexPath.row)
            UserDefault.Index.remove(at: indexPath.row)
            if self!.fAmount.count != 0 {
                self!.fAmount.remove(at: indexPath.row)
            }
            self!.showErrorToast(message: "Removed from favourites", seconds: 2.0)
            
            tableView.reloadData()
            
            completionHandler(true)
        }
        swpGroup.backgroundColor = .red
        //tableView.reloadData()
        let configuration = UISwipeActionsConfiguration (actions: [swpGroup])
        return configuration
        
    }
    
    
}

//MARK: - GADBannerView Delegate
extension FavouritesVC: GADBannerViewDelegate {
    
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            
                
                print("Banner loaded successfully")
                let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
                bannerView.transform = translateTransform
            
                UIView.animate(withDuration: 0.5) {
                    self.tblVcountry.tableHeaderView?.frame = bannerView.frame
                    bannerView.transform = CGAffineTransform.identity
                    self.tblVcountry.tableHeaderView = bannerView
                }
            
        }
        
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            
                print("Fail to receive ads")
                print(error.localizedDescription)
            
        }
    
}
//MARK: - API Calling
extension FavouritesVC {
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
        let baseCurrency = lblFCurrency.text ?? ""
        
        if UserDefault.Favourite.count == 0 {
            self.showErrorToast(message: "Add some favourite countries", seconds: 2.0)
            return
        }else {
            
            
            RequestServices.shared.getData(endUrl:"?amount=\(amount)&base_currency=\(baseCurrency)" ) { response, error in
                
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                if let data : Data = response as? Data {
                    let decoder = JSONDecoder()
                    do {
                        self.apiCalled = true
                        let countries = try decoder.decode(Currency_Main_Model.self, from: data)
                        self.currencies = countries.data
                        let doubleStr = String(format: "%.2f", Double(countries.data.USD ?? 0.0)) // "3.14"
                        //                    self.lblAmount.text = doubleStr
                        print("DATA: ",self.currencies)
                        self.getFavAmounts()
                        
                        
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
}
//MARK: - Custom Delegates
extension FavouritesVC: BaseCurrencyDelegate {
    func didSelectCountry(cntryNm: String, crncyNm: String) {
        self.lblFCountry.text = cntryNm
        self.lblFCurrency.text = crncyNm
    }
    
    
}
