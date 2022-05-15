//
//  SneakerStoreApp.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 01.05.2022.
//

import SwiftUI
import Firebase

@main
struct SneakerStoreApp: App {
    @StateObject var vm: AuthViewModel = AuthViewModel()
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(vm)
            .preferredColorScheme(.light)
        }
    }
}
