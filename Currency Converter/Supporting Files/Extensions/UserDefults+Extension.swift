//
//  UserDefults+Extension.swift
//  Currency Converter
//
//  Created by Horizam on 01/02/2023.
//

import Foundation

struct UserDefault {
    
    private struct key {
        
        static let arrFav           = "arrFav"
        static let arrInd           = "arrInd"
     
    }
    
    static var Favourite: [[String]] {
        
        get {
            
            return UserDefaults.standard.array(forKey: key.arrFav) as? [[String]] ?? [[""]]
            
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: key.arrFav)
            
        }
    }
    
    static var Index: [Int] {
        
        get {
            
            return UserDefaults.standard.array(forKey: key.arrInd) as? [Int] ?? [0]
            
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: key.arrInd)
            
        }
    }
}
