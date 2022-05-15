//
//  SneakerRowView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 01.05.2022.
//

import SwiftUI
import Kingfisher

struct SneakerRowView: View {
    let sneaker: Result
    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [.purple, .orange]), startPoint: .top, endPoint: .bottom)
            LinearGradient(gradient: Gradient(colors: [.purple, .orange]), startPoint: .topTrailing, endPoint: .bottomLeading)

            VStack(alignment: .leading, spacing: -45) {
                KFImage(URL(string: sneaker.image?.original ?? ""))
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 80, height: 320, alignment: .center)
                    .scaledToFill()
                    .shadow(radius: 7)
                    VStack(alignment: .leading) {
                        Text(sneaker.name?.uppercased() ?? "")
                            .font(Font.custom("Poppins-Bold", size: 20))
                            .foregroundColor(.black.opacity(0.8))
                            .lineLimit(1)
                        Text("Price: \(sneaker.retailPrice ?? 100)$")
                            .font(Font.custom("Poppins-Medium", size: 20))
                            .foregroundColor(.black.opacity(0.8))
                            .padding(.bottom, 20)

                    }
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                }
                .frame(width: UIScreen.main.bounds.width - 80, height: 335) // remove

        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 345)
        .cornerRadius(10)
    }
}



