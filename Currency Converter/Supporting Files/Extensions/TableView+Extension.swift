//
//  TableView+Extension.swift
//  Currency Converter
//
//  Created by Hamid on 03/02/2023.
//

import Foundation
import UIKit
import GoogleMobileAds
class TableHeaderView: UIView, GADBannerViewDelegate {
  let searchBar: UISearchBar
  let adBannerView: GADBannerView

  override init(frame: CGRect) {
    searchBar = UISearchBar(frame: frame)
    adBannerView = GADBannerView(frame: frame)

    super.init(frame: frame)

    // Add the search bar and ad banner view as subviews.
    addSubview(searchBar)
    addSubview(adBannerView)

    // Set the delegate for the ad banner view.
    adBannerView.delegate = self
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
