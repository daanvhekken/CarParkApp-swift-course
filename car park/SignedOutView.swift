//
//  SignupView.swift
//  car park
//
//  Created by Daan Vanhekken on 30/10/2022.
//

import SwiftUI
import FirebaseAuth

struct SignedOutView: View {
    @State var isLogin = false
    
    var body: some View {
        LottieView(lottieFile: "car-animation")
            .frame(width: 300, height: 300)
        Picker("", selection: $isLogin) {
            Text("Inloggen")
                .tag(true)
            Text("Creëer Account")
                .tag(false)
        }.pickerStyle(SegmentedPickerStyle())
            .padding()
        
        if isLogin {
            LoginView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.move(edge: .leading))
        } else {
            SignUpView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.move(edge: .leading))
        }
    }
}

struct SignedOutView_Previews: PreviewProvider {
    static var previews: some View {
        SignedOutView()
    }
}
