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
            .selectedSegmentTintColor = UIColor(.white)
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 20) {
                //Apps name
//                Text("Rumahku")
//                    .fontWeight(.heavy)
//                    .foregroundColor(.primary)
//                    .font(.largeTitle)
                Text("Plan your Dream House")
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
                
                
                // Building detail input
                TitleView(title: "Input your building detail")
                VStack {
                    HStack {
                        TextField("Length", text: $panjang)
                            .foregroundColor(.primary)
                            .font(.title)
                            .keyboardType(.decimalPad)
                            .focused($isInputActive)
                            .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
                        
                        Text("meter")
                            .foregroundColor(.primary)
                            .font(.largeTitle)
                            .fontWeight(.medium)
                    }
                    HStack {
                        TextField("Width", text: $lebar)
                            .foregroundColor(.primary)
                            .font(.title)
                            .keyboardType(.decimalPad)
                            .focused($isInputActive)
                            .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
                        
                        Text("meter")
                            .foregroundColor(.primary)
                            .font(.largeTitle)
                            .fontWeight(.medium)
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
                .padding()
                
                //Card view for Building Area
                CardView2(cardLabelText: "Building Area", totalSquare: cobaLuas, totalLength: length, totalWidth: width)
                    .frame(width: geo.size.width, height: 100)
                
                TitleView(title: "Price Option Square Meter")
                //Price option picker
                Picker("Price option", selection: $ratePrice) {
                    ForEach(0..<ratePrices.count) {
                        Text("IDR \(self.ratePrices[$0]) jt")
                            .foregroundColor(.primary)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                //Card view for Total Price
                CardView(cardLabelText: "Total Price", totalAmount: hargaBangunan)
                    .frame(width: geo.size.width, height: 100)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}

// Struct for every title
struct TitleView: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
                .fontWeight(.medium)
            Spacer()
        }
    }
}
