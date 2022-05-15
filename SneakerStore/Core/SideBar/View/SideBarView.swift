//
//  SideBarView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 01.05.2022.
//

import SwiftUI

struct SideBarView: View {
    @EnvironmentObject var vm: AuthViewModel
    
    @Binding var showSideBar: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 150)
                        .padding(.top, 50)
                    Spacer()
                    Button {
                        withAnimation(.spring()) {
                            showSideBar.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .padding()
                            .offset(x: 0, y: -30)
                    }

                }
                VStack {
                    NavigationLink {
                        HistoryView()
                            .navigationBarHidden(true)
                    } label: {
                        SideBarRowView(imageName: "archivebox", text: "History")
                    }
                    NavigationLink {
                        ShopLocationView()
                            .navigationBarHidden(true)
                    } label: {
                        SideBarRowView(imageName: "mappin.and.ellipse", text: "Offline")
                    }


                    Button {
                        vm.singOut()
                    } label: {
                        SideBarRowView(imageName: "arrow.left.square", text: "Logout")
                    }

                }
                Spacer()
            }
            
        }
    }
    
    
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView(showSideBar: .constant(true))
    }
}
