//
//  DetailView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 01.05.2022.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    
    @Environment(\.presentationMode) var mod
    @StateObject var vm = DetailViewModel()
    let sneaker: Result
    
    var body: some View {
        VStack() {
            KFImage(URL(string: sneaker.image?.original ?? ""))
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 20, height: 300)
                .background(.linearGradient(colors: [.red, .orange], startPoint: .top, endPoint: .bottom))
                .cornerRadius(30)
                .padding(.top, 20)
            VStack(alignment: .leading, spacing: 5) {
                Text(sneaker.name ?? "")
                    .font(Font.custom("Poppins-Bold", size: 30))
                Text("Price: \(sneaker.retailPrice ?? 100)$")
                    .font(Font.custom("Poppins-Medium", size: 30))
                    Text("Colors : \(sneaker.colorway ?? "")")
                            .font(Font.custom("Poppins-Medium", size: 16))
                    Text("Released date : \(sneaker.releaseDate ?? "")")
                            .font(Font.custom("Poppins-Medium", size: 16))
                ScrollView {
                    Text(sneaker.story ?? "No description...")
                        .font(Font.custom("Poppins-Medium", size: 18))
                        .padding(.vertical)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.top, 20)
            HStack {
                Button {
                    vm.saveInCartList(name: sneaker.name ?? "Air Force", price:Int16(sneaker.retailPrice ?? 100), imageUrl: sneaker.image?.original ?? "") { complete in
                        self.mod.wrappedValue.dismiss()
                    }
                } label: {
                    HStack {
                        Image(systemName: "cart")
                        Text("Add to cart")
                            .font(Font.custom("Poppins-Bold", size: 16))
                    }
                    .padding(.horizontal, 50)
                    .padding(.vertical, 15)
                    .background(.orange)
                    .cornerRadius(20)
                }
                .foregroundColor(.white)
                .shadow(radius: 5)
                Button {
                    vm.minusItem()
                } label: {
                    Image(systemName: "minus.circle")
                        .foregroundColor(.red)
                        .font(.title2)
                }
                Text("x\(vm.sneakerCount)")
                    .foregroundColor(.black)
                    .font(Font.custom("Poppins-Bold", size: 16))
                Button  {
                    vm.plusItem()
                 } label: {
                     Image(systemName: "plus.circle")
                         .foregroundColor(.green)
                         .font(.title2)
                 }
            }
        }
    }
}

