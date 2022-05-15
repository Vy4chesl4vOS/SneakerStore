//
//  TextFieldView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 01.05.2022.
//

import SwiftUI

struct TextFieldView: View {
    
    @Binding var text: String
    let placeholder: String
    let imageName: String
    let color: Color
    let secure: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: imageName)
                .font(.title)
                .foregroundColor(color)
            if secure {
                SecureField(placeholder, text: $text)
                    .font(Font.custom("Poppins-Medium", size: 15))
                    .frame(width: 270, height: 60)
                    .autocapitalization(.none)
            } else {
                TextField(placeholder, text: $text)
                    .font(Font.custom("Poppins-Medium", size: 15))
                    .frame(width: 270, height: 60)
                    .autocapitalization(.none)
            }
        }
        .padding(.horizontal, 10)
        .background {
            RoundedRectangle(cornerRadius: 20).stroke(.black ,lineWidth: 1)
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(text: .constant(""), placeholder: "Email", imageName: "person.circle", color: .blue, secure: true)
    }
}
