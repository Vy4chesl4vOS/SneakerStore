//
//  ShopLocationView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 04.05.2022.
//

import SwiftUI
import MapKit

struct ShopLocationView: View {
    @StateObject var vm = ShopLocationViewModel()
    @Environment(\.presentationMode) var mod
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.currentMapRegion, annotationItems: vm.locations, annotationContent: { location in
                MapAnnotation(coordinate: location.coordintaes) {
                    VStack(spacing: 0) {
                        Image("logo")
                            .resizable()
                            .frame(width: 128, height: 128)
                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .offset(x: 0, y: -15)
                            .foregroundColor(.red)
                    }
                    .shadow(color: .gray, radius: 10)
    
                }
            })
            
            VStack {
                headerView
                Spacer()
//                ForEach(vm.locations) { location in
                DownView(location: vm.currentLocation)
                    .padding(.bottom, 30)
//                }
            }
        }
        .ignoresSafeArea()
    }
    private var headerView : some View {
        HStack {
            Button {
                mod.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.red)

            }

            HStack {
                Text(vm.currentLocation.name == "Shop #1" ? "Moscow" : "Peterburg")
                    .font(Font.custom("Poppins-Light", size: 23))
                    .foregroundColor(.black)
                Button {
                    withAnimation(.easeInOut) {
                        vm.nextLocation()
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .foregroundColor(.green)
                }

            }
            .padding(.horizontal, 90)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white)
            }
            .shadow(radius: 10)
        }
        .padding(.top, 50)
    }
}

struct ShopLocationView_Previews: PreviewProvider {
    static var previews: some View {
        ShopLocationView()
    }
}


struct DownView : View {
    var location: Location
    var body: some View {
        HStack (alignment: .top){
                    Image(location.imageName)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFill()
                        .cornerRadius(15)
                        .padding(10)

            VStack(alignment: .leading) {
                Text(location.name)
                    .font(Font.custom("Poppins-Medium", size: 24))
                Text(location.workTime)
                    .font(Font.custom("Poppins-Medium", size: 20))
                Text(location.adress)
                    .font(Font.custom("Poppins-Light", size: 20))
            }

            }
        .padding(15)
        .background(.thinMaterial)
        .cornerRadius(15)
    }
}
