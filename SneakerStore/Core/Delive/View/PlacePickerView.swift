//
//  PlacePickerView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 07.05.2022.
//

import SwiftUI

struct PlacePickerView: View {
    @EnvironmentObject var vm: DeliveViewModel
    @Environment(\.presentationMode) var mod
    var body: some View {
        VStack {
            SearchFieldView(text: $vm.placeText)
                .padding()
                .padding(.top, 15)
            List {
                    ForEach(vm.places, id: \.self) { place in
                        Button {
                            vm.location = place.location
                            mod.wrappedValue.dismiss()
                        } label: {
                            Text("\(place.title ?? "")")
                        }

                    }
            }.listStyle(.plain)
        }.onChange(of: vm.placeText) { newValue in
            let delay = 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if newValue == vm.placeText {
                    vm.searchPlaces()
                }
            }
        }
    }
}

struct PlacePickerView_Previews: PreviewProvider {
    static var previews: some View {
        PlacePickerView()
    }
}
