//
//  HistoryView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 08.05.2022.
//

import SwiftUI
import Kingfisher

struct HistoryView: View {
    @StateObject var vm = HistoryViewModel()
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
                Text("History")
                    .font(Font.custom("Poppins-Bold", size: 28))
                Spacer()
            }
            .padding()
            ScrollView {
                LazyVStack {
                    ForEach(vm.orders) { order in
                        HistoryRowView(order: order)
                            .padding()
                        Divider()
                    }
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
