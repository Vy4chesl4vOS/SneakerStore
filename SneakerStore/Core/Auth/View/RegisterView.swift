//
//  RegisterView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 01.05.2022.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var vm: AuthViewModel
    @Environment(\.presentationMode) var mod
    
    
    @State private var email = ""
    @State private var password = ""
    @State private var fullName = ""
    
    
    var body: some View {
        VStack {
            logo
            loginForm
            Button {
                vm.registerUser(email: email, password: password, fullName: fullName)
            } label: {
                Text("Register")
                    .foregroundColor(.white)
                    .font(.custom("Poppins-Bold", size: 15))
            }
            .frame(width: 270, height: 60)
            .background(.black)
            .cornerRadius(15)
            .padding(.top, 50)


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
            TextFieldView(text: $fullName, placeholder: "Full Name", imageName: "person.text.rectangle", color: .yellow, secure: false)

                Button {
                    mod.wrappedValue.dismiss()
                } label: {
                    Text("Already have an account?")
                        .foregroundColor(.black)
                        .underline()
                        .font(.custom("Poppins-Light", size: 15))
                }

        }
        .padding(.top, 10)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
