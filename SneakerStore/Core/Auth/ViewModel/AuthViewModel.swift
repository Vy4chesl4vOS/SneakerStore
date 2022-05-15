//
//  AuthViewModel.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 02.05.2022.
//

import Foundation
import Firebase


class AuthViewModel : ObservableObject {
    @Published var currentSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    let service = UserService()
    
    init () {
        currentSession = Auth.auth().currentUser
        fetchUser()
    }
    
    
    func loginUser(email: String, password: String) {
        Firebase.Auth.auth().signIn(withEmail: email, password: password) {[weak self] result, error in
            if let error = error {
                print("\(error.localizedDescription)")
                return
            }
            guard let session = result?.user else { return }
            self?.currentSession = session
            self?.fetchUser()
        }
    }
    
    func registerUser(email: String, password: String, fullName: String) {
        Firebase.Auth.auth().createUser(withEmail: email, password: password) {[weak self] result, error in
            if let error = error {
                print("\(error.localizedDescription)")
                return
            }
            guard let session = result?.user else { return }
            self?.currentSession = session
            self?.storeUser(email: email, fullName: fullName)
            self?.fetchUser()
        }
    }
    
    func storeUser(email: String, fullName: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data = ["email": email, "fullname": fullName, "uid": uid] as [String: Any]
        Firebase.Firestore.firestore().collection("users").document(uid).setData(data) { error in
            if let error = error {
                print("\(error.localizedDescription)")
                return
            }
        }
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        service.fetchUser(uid: uid) {[weak self] user in
            self?.currentUser = user
        }
    }
    
    func singOut () {
        try? Firebase.Auth.auth().signOut()
        self.currentUser = nil
        self.currentSession = nil
    }
    
}
