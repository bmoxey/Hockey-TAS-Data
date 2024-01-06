//
//  LoadingView.swift
//  Hockey TAS Data
//
//  Created by Brett Moxey on 3/1/2024.
//

import SwiftUI

struct LoadingView: View {
    @Binding var current: Double
    @Binding var maximum: Double
    @Binding var message: String
    var body: some View {
        VStack {
            Spacer()
            Image("AppText")
                .resizable()
                .frame(width: 273, height: 100)
            Image("AppPic")
                .resizable()
                .scaledToFit()
                .padding(.bottom, -4)
            ProgressView(message, value: current, total: maximum)
                .foregroundStyle(Color("AccentColor"))
                .padding()
            Spacer()
        }
        .background(LinearGradient(
            gradient: Gradient(colors: [Color("DarkColor1"), Color("DarkColor2")]),
            startPoint: .top, endPoint: .bottom ))
    }
}

#Preview {
    LoadingView(current: .constant(1), maximum: .constant(10), message: .constant("Searching ..."))
}
