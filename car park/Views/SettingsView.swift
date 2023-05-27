//
//  SettingsView.swift
//  car park
//
//  Created by Daan Vanhekken on 02/11/2022.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        Button {
            authViewModel.signOut()
        } label: {
            Text("Sign-out")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 340, height: 50)
                .background(Color(.systemBlue))
                .clipShape(Capsule())
                .padding()
            
        }.shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
