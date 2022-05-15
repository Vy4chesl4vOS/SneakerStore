//
//  SideBarRowView.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 01.05.2022.
//

import SwiftUI

struct SideBarRowView: View {
    let imageName: String
    let text: String
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: imageName)
            Text(text)
                .font(Font.custom("Poppins-Light", size: 20))
            Spacer()
        }
        .foregroundColor(.white)
        .padding()
    }
}

