//
//  MainView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 01.05.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var cartVm = CartListViewModel()
    @StateObject var mainViewModel = MainViewModel()
    
    @EnvironmentObject var vm: AuthViewModel
    
    @State private var currentCategory: Categories = .all
    @State private var showSideBar = false
    
    @State private var currentItem: Result?
    
    init () {
        NotificationManager.shared.sendEveryMonthNotification()
    }
    
    var body: some View {
        ZStack {
            if showSideBar {
                SideBarView(showSideBar: $showSideBar)
            }
            mainInterface
                .background(.white)
                .cornerRadius(showSideBar ? 30 : 10)
                .offset(x: showSideBar ? 250 : 0, y: showSideBar ? 44 : 0)
                .scaleEffect(showSideBar ? 0.8 : 1.0)
                .blur(radius: showSideBar ? 10 : 0)
                .padding(.top, 60)
                .ignoresSafeArea()
                .onAppear {
                    self.showSideBar = false
                }
        }
    }
    
    private var mainInterface : some View  {
        VStack {
            headerView
            scrollData
        }
    }
    
    private var headerView : some View {
            HStack(spacing: 20) {
                if !showSideBar {
                    Button {
                        withAnimation(.spring()) {
                            showSideBar.toggle()
                        }
                    } label: {
                        Image(systemName: "list.dash")
                            .foregroundColor(.accentColor)
                            .font(.title2)
                    }
                }
                                
                    Spacer()
                NavigationLink {
                    CartListView()
                        .navigationBarTitleDisplayMode(.inline)
                        .environmentObject(cartVm)
                } label: {
                    ZStack(alignment: .bottomTrailing) {
                        Image(systemName: "cart")
                            .font(.title2)
                            .foregroundColor(.black)
                        if !cartVm.sneakers.isEmpty {
                            Image(systemName: "circle.fill")
                                .foregroundColor(.orange)
                                .font(.system(size: 10))
                                .shadow(radius: 2)
                                .offset(x: 0, y: 4)
                        }
                    }
                }

            }
            .padding(.horizontal)
            .padding(.vertical, 1)

    }
    
    private var categories : some View {
        VStack(alignment: .leading,spacing: 20) {
            Text("Categories")
                .font(Font.custom("Poppins-Bold", size: 28))
                .padding(.horizontal)
                .padding(.top, 15)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(Categories.allCases, id: \.self) { category in
                        if currentCategory == category {
                            Button {
                                //
                            } label: {
                                Text("\(category.rawValue)")
                                    .foregroundColor(.white)
                                    .frame(width: 95, height: 40)
                                    .font(Font.custom("Poppins-Medium", size: 16))
                                    .background {
                                        Capsule().fill()
                                    }
                                    .padding(1)
                            }
                        } else {
                            Button {
                                withAnimation(.easeIn) {
                                    currentCategory = category
                                }
                            } label: {
                                Text("\(category.rawValue)")
                                    .frame(width: 95, height: 40)
                                    .foregroundColor(.accentColor)
                                    .font(Font.custom("Poppins-Medium", size: 16))
                                    .background {
                                        Capsule().stroke(lineWidth: 1)
                                    }
                                    .padding(1)
                            }
                        }
                    }
                }
            }
        }
    }
    private var scrollData : some View {
        ScrollView(showsIndicators: false) {
            categories
                .padding(.bottom, 20)
            LazyVStack {
                if let sneakers = mainViewModel.filteredSneakers {
                    ForEach(sneakers.results) { sneaker in
                        if sneaker.brand == currentCategory.description {
                            Button {
                                self.currentItem = sneaker
                            } label: {
                                SneakerRowView(sneaker: sneaker)
                            }
                        } else if currentCategory == .all {
                            Button {
                                self.currentItem = sneaker
                            } label: {
                                SneakerRowView(sneaker: sneaker)
                            }
                        }
                }
                    .onAppear(perform: {
                        self.currentItem = nil
                    })
                    .sheet(item: $currentItem) { item in
                        DetailView(sneaker: item)
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
