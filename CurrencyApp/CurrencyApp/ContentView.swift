//
//  ContentView.swift
//  CurrencyApp
//
//  Created by Armagan Ercan on 2023-11-11.
//

import SwiftUI
import Combine
import Foundation

struct ContentView: View {
    
    @ObservedObject var currencyManager = CurrencyManager()
    @State private var currency:CurrencyResponse?
    
    @State private var isConversionView = false
    
    @State private var basename = ""
    
    
    var body: some View {
    
            VStack{
                HStack{
                    Text("Currency Rates").bold().font(.system(size: 20)).padding()
                    
                    Button{
                        
                        isConversionView = true
                        
                    }label: {
                        //Image(systemName: "arrow.up.right.and.arrow.down.left.rectangle").font(.system(size:20))
                        Text("Conversion").font(.system(size: 20)).frame(alignment: .trailing)
                    }.frame(alignment: .trailing)
                        .sheet(isPresented: $isConversionView) {
                            ConversionView()
                        }
                }
                
                TextField("Search a Currency", text: $basename){
                    currencyManager.APIRequest(by: basename) { result in
                        
                        switch result{
                        case .success(let currency):
                            self.currency = currency
                        case .failure(let error):
                            print("\(error)")

                        }

                    }

                    
                }
                
                if let currencyBase = currencyManager.currency {
                    
                    
                    Text("Base Currency: \(currencyBase.base)")
                }
                
                if let currencyDate = currencyManager.currency{
                    
                    Text("Date: \(currencyDate.date)")
                    
                }
            } .frame(alignment: .center)
            
            
            
            
            List((currencyManager.currency?.rates.sorted(by: { $0.key < $1.key }) ?? []), id: \.key){ (key,item) in
                
                VStack{
                    HStack{
                        Text(key)
                            .padding()
                        Text("\(item)")
                        
                    }
                }
                
            }.onAppear{
                
                currencyManager.APIRequest(by: basename) { result in
                    DispatchQueue.main.async {
                        switch result{
                        case .success(let currency):
                            self.currency = currency
                        case .failure(let error):
                            print("\(error)")
                            
                            
                            
                        }
                    }
                    
                }

                
            }
        
        }
}
                                           
                                           
                                        
                                           
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
