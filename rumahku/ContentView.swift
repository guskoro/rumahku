//
//  ContentView.swift
//  rumahku
//
//  Created by Guskoro Pradipta on 11/05/22.
//

import SwiftUI

struct ContentView: View {
    @State private var panjang = ""
    @State private var lebar = ""
    @State private var ratePrice = 1
    @FocusState private var isInputActive: Bool
    private var length: Double { Double(panjang) ?? 0 }
    private var width: Double { Double(lebar) ?? 0 }
    
    //Price option
    private let ratePrices = [1, 3, 4, 5, 6]
    
    //Count building area
    private var cobaLuas: Double {
        let panjangBangunan = Double(panjang) ?? 0
        let lebarBangunan = Double(lebar) ?? 0
        
        return panjangBangunan * lebarBangunan
    }
    
    //Count building price
    private var hargaBangunan: Double {
        let rateSelection = Double(ratePrices[ratePrice])
        let panjangBangunan = Double(panjang) ?? 0
        let lebarBangunan = Double(lebar) ?? 0
        
        let luasBangunan = panjangBangunan * lebarBangunan
        let rateMillion = rateSelection * 1000000
        let hargaTotal = luasBangunan * rateMillion
        
        return hargaTotal
    }
    
    init() {
        UISegmentedControl.appearance()
            .selectedSegmentTintColor = UIColor(.mint)
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 20) {
                //Apps name
                Text("Rumahku")
                    .foregroundColor(.primary)
                    .font(.system(size: 40, weight: .black, design: .default))
                Text("Budget Plan")
                    .foregroundColor(.primary)
                    .font(.system(size: 20, weight: .black, design: .default))
                
                //Card view for Total Price
                CardView(cardLabelText: "Total Price", totalAmount: hargaBangunan)
                    .frame(width: geo.size.width, height: 100)
                
                //Card view for Building Area
                CardView2(cardLabelText: "Building Area", totalSquare: cobaLuas, totalLength: length, totalWidth: width)
                    .frame(width: geo.size.width, height: 100)
                
                TitleView(title: "Price Option")
                //Price option picker
                Picker("Price option", selection: $ratePrice) {
                    ForEach(0..<ratePrices.count) {
                        Text("IDR \(self.ratePrices[$0]) jt")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                .padding()
                
                // Building detail input
                TitleView(title: "Building detail")
                VStack {
                    HStack {
                        TextField("Length", text: $panjang)
                            .foregroundColor(.primary)
                            .font(.system(size: 40, weight: .black, design: .rounded))
                            .keyboardType(.decimalPad)
                            .focused($isInputActive)
                        
                        Text("meter")
                            .foregroundColor(.primary)
                            .font(.system(size: 40, weight: .black, design: .rounded))
                    }
                    HStack {
                        TextField("Width", text: $lebar)
                            .foregroundColor(.primary)
                            .font(.system(size: 40, weight: .black, design: .rounded))
                            .keyboardType(.decimalPad)
                            .focused($isInputActive)
                        
                        Text("meter")
                            .foregroundColor(.primary)
                            .font(.system(size: 40, weight: .black, design: .rounded))
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                isInputActive = false
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

// Struct for every title
struct TitleView: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.mint)
                .fontWeight(.black)
            Spacer()
        }
    }
}
