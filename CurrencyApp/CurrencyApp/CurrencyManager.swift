//
//  CurrencyManager.swift
//  CurrencyApp
//
//  Created by Armagan Ercan on 2023-11-11.
//

import Foundation
import SwiftUI
import Combine

class CurrencyManager:ObservableObject{
    
    @Published var currency:CurrencyResponse?
    @Published var currencyResult:CurrencyResult?
   
    
    

    func ConvertAPIRequest(for currencyTo:String, for currencyFrom:String,for amo:String, completion: @escaping (Result<CurrencyResult, CurrencyError>) -> Void){
        
        URLSession.shared.dataTask(with: URL(string: "https://api.apilayer.com/fixer/convert?apikey=q20U7uEkIl0Swn79zRjZiwrES6W00J3R&to=\(currencyTo)&from=\(currencyFrom)&amount=\(amo)")!) { data, response, error in
            if let data = data {
                let response = try? JSONDecoder().decode(CurrencyResult.self, from: data)
                DispatchQueue.main.async {
                    if let response = response{
                        
                        self.currencyResult = response
                        
                    }else{
                        
                        completion(.failure(.invalidURL))
                        
                    }
                }
                
                
            }
        }.resume()
        
        
        
    }
    
    func APIRequest(by base: String, completion: @escaping(Result<CurrencyResponse, CurrencyError>) -> Void) {
      
        URLSession.shared.dataTask(with: URL(string: "https://api.apilayer.com/fixer/latest?base=\(base)&apikey=q20U7uEkIl0Swn79zRjZiwrES6W00J3R")!) { data, response, error in
            if let data = data {
                let response = try? JSONDecoder().decode(CurrencyResponse.self, from: data)
                DispatchQueue.main.async {
                    if let response = response{
                        
                        self.currency = response
                        
                    }else{
                        
                        completion(.failure(.invalidURL))
                        
                    }
                }
                
                
            }
        }.resume()
        
        
        
        
        
    }

    
    
    enum CurrencyError: Error{
        case invalidURL
        case invalidData
        case invalidTask
        case invalidResponse
        case invalidSession
        
    }
}
