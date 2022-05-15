//
//  CartListView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 03.05.2022.
//

import SwiftUI

struct CartListView: View {
    @EnvironmentObject var vm: CartListViewModel
    @Environment(\.presentationMode) var mod
    
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    mod.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.red)
                        .font(.title2)
                }
                Spacer()
                Text("Cart List")
                    .font(Font.custom("Poppins-Bold", size: 28))
                Spacer()
            }
            .padding()

            List {
                ForEach(vm.sneakers) { sneaker in
                    CartListRowView(sneaker: sneaker)
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        vm.deleteSneaker(sneaker: vm.sneakers[index])
                    }
                }
                if !vm.sneakers.isEmpty {
                    Button {
                        withAnimation(.easeOut) {
                            vm.deleteAll()
                        }
                    } label: {
                        Text("Delete all")
                            .foregroundColor(.red)
                            .font(Font.custom("Poppins-Bold", size: 16))
                    }
                }
            }
            .listStyle(.plain)
            Spacer()
                Text("Total Price: \(vm.computeTotalPrice())$")
                    .foregroundColor(.black)
                    .font(Font.custom("Poppins-Medium", size: 16))
            if vm.sneakers.count > 0 {
                NavigationLink {
                    DeliveView()
                        .navigationBarHidden(true)
                        .environmentObject(vm)
                }  label: {
                    Text("Delive")
                        .foregroundColor(.white)
                        .font(Font.custom("Poppins-Medium", size: 16))
                        .padding(.horizontal, 100)
                        .padding(.vertical, 15)
                }
                .background(.green)
                .cornerRadius(15)
            }
            


        }
        .navigationBarHidden(true)
    }
}

struct CartListView_Previews: PreviewProvider {
    static var previews: some View {
        CartListView()
    }
}
