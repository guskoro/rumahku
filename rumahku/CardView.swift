//
//  CardView.swift
//  rumahku
//
//  Created by Guskoro Pradipta on 11/05/22.
//

import SwiftUI

// CARD VIEW FOR TOTAL PRICE
struct CardView: View {
    var cardLabelText = ""
    var totalAmount = 100.12
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(cardLabelText)
                .foregroundColor(.primary)
                .fontWeight(.medium)
            Spacer()
            
            ZStack {
                Rectangle()
                    .foregroundColor(.primary)
                    .cornerRadius(10)
                HStack {
                    Spacer()
                    
                    Text("IDR \(totalAmount, specifier: "%.2f")")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .black, design: .monospaced))
                        .fontWeight(.black)
                    
                    Spacer()
                    
                    Rectangle()
                        .foregroundColor(Color(red: 128/255, green: 128/255, blue: 128/255))
                        .frame(width: 1, height: 70)
                    .foregroundColor(.primary)
                }
                .padding(5)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(cardLabelText: "Total Price")
            .frame(width: 300, height: 150)
    }
}
