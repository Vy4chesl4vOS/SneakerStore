//
//  CartListRowView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 03.05.2022.
//

import SwiftUI
import Kingfisher

struct CartListRowView: View {
    let sneaker: SavedSneakerModel
    
    var body: some View {
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
}
