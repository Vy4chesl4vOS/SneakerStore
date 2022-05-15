//
//  ContentView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 01.05.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: AuthViewModel
    
    init() {
        NotificationManager.shared.requestAuth()
    }
    
    
    var body: some View {
        if vm.currentSession == nil {
            AuthView()
                .navigationBarHidden(true)
        } else {
            MainView()
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
