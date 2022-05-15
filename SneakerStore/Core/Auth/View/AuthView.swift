//
//  AuthView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 01.05.2022.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var vm: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            logo
            loginForm
            Button {
                vm.loginUser(email: email, password: password)
            } label: {
                Text("Login")
                    .foregroundColor(.white)
                    .font(.custom("Poppins-Bold", size: 15))
                    .padding(.horizontal, 120)
                    .padding(.vertical, 20)
                    .background(.black)
                    .cornerRadius(15)
                    .padding(.top, 50)
            }



            Spacer()
        }
    }
    
    private var logo : some View {
            ZStack() {
                Image("logo")
                    .resizable()
                    .frame(width: 300, height: 200)
                    .shadow(radius: 10)
                    .padding(.top, 100)
            }
    }
    
    private var loginForm : some View {
        VStack(spacing: 15) {
            TextFieldView(text: $email, placeholder: "Email", imageName: "person.circle", color: .blue, secure: false)
            TextFieldView(text: $password, placeholder: "Password", imageName: "lock.circle", color: .red, secure: true)
                //
                NavigationLink {
                    RegisterView()
                        .navigationBarHidden(true)
                } label: {
                    Text("Haven't account?")
                        .foregroundColor(.black)
                        .underline()
                        .font(.custom("Poppins-Light", size: 15))
                }
            
        }
        .padding(.top, 10)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
