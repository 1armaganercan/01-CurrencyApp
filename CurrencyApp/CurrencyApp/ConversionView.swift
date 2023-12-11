//
//  CurrencyConvert.swift
//  CurrencyApp
//
//  Created by Armagan Ercan on 2023-11-12.
//

import SwiftUI
import Combine


struct ConversionView: View {
    @ObservedObject var currencyManager = CurrencyManager()
    @State private var currency: CurrencyResponse?
    @State private var currencyResult:CurrencyResult?
    
    @State private var fromCurrency = ""
    @State private var toCurrency = ""
    @State private var amo: String = ""
    
    @State private var currentDate = Date()
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
    
    
    var body: some View {
        
        
            VStack {
                
                
                Text("\(currentDate, formatter: dateFormatter)")
                
                
                TextField("Which currency are you using", text: $toCurrency)
                TextField("Which currency are you converting to", text: $fromCurrency)
                TextField("Amount",text: $amo)
      
                Button("Convert") {
                    currencyManager.ConvertAPIRequest(for: fromCurrency, for: toCurrency, for: amo) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let currency):
                                self.currencyResult = currency
                            case .failure(let error):
                                print("Error: \(error.localizedDescription)")
                                // Handle the error state in the UI as well
                            }
                        }
                    }
                }
                
                if let result = currencyManager.currencyResult?.result {
                    
                    Text("\(result)")
                }
            }
            
            
         
        
    }
    
}

struct CurrencyConvert_Previews: PreviewProvider {
    static var previews: some View {
        ConversionView()
    }
}
