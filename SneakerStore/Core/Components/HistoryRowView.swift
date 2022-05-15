//
//  HistoryRowView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 08.05.2022.
//

import SwiftUI
import Kingfisher

struct HistoryRowView: View {
    @State private var showSneakers = false
    
    let order: Order
    
    var body: some View {
        VStack() {
            HStack(spacing: 25) {
                Text("\(order.timestamp.dateValue().toString())")
                    .font(Font.custom("Poppins-Medium", size: 18))
                    .foregroundColor(.black)
                Spacer()
                Text("Total: \(order.totalPrice)$")
                    .font(Font.custom("Poppins-Medium", size: 18))

            }
            .padding()
            if !showSneakers {
                Button {
                    withAnimation(.spring()) {
                        showSneakers.toggle()

                    }
                } label: {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.blue)
                }
            } else {
                if let sneakers = order.sneakers {
                    Text("\(order.status)")
                        .font(Font.custom("Poppins-Bold", size: 18))
                    ForEach(sneakers) { sneaker in
                        HStack {
                            KFImage(URL(string: sneaker.imageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text(sneaker.name.uppercased())
                                    .font(Font.custom("Poppins-Bold", size: 15))
                                Text("\(sneaker.price)$ (x\(sneaker.count))")
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    Button {
                        withAnimation(.spring()) {
                            showSneakers.toggle()

                        }
                    } label: {
                        Image(systemName: "chevron.up")
                            .foregroundColor(.red)
                    }

                }
                    
            }

        }

    }
}

