//
//  CurrencyModel.swift
//  CurrencyApp
//
//  Created by Armagan Ercan on 2023-11-11.
//

import Foundation
import SwiftUI
import Combine

struct CurrencyResponse: Decodable{
    
    
 
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String:Double]
    //var result: Double
    
    
    
}

struct CurrencyResult:Decodable{
    
    let date:String
    let result:Double
   
    
    
    
}


/*struct CurrencyModel:Decodable, Identifiable{
    
    var id:Int
    var USD:Double
    var CAD:Double
    var EUR:Double
    var TRY:Double
    var SEK:Double
    var BTC:Double
    var CHF:Double

    
}*/

