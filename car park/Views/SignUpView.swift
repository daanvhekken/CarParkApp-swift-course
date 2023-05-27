//
//  SignupView.swift
//  car park
//
//  Created by Daan Vanhekken on 30/10/2022.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State var textFieldEmail = ""
    @State var textFieldPassword = ""
    @State var textFieldFirstName = ""
    @State var textFieldLastName = ""
    
    var body: some View {
        VStack() {
            VStack(alignment: .leading) {
                HStack { Spacer() }
                
                Text("Laten we beginnen.")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("Creëer je account")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            .frame(height: 260)
            .padding(.leading)
            .background(RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650))
            .foregroundColor(.white)
            .clipShape(RoundedShape(corners: [.bottomRight]))
            
            VStack(spacing: 40) {
                if authViewModel.errorDescr != "" {
                    Text(authViewModel.errorDescr)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.leading)
                }
                TextField("Voornaam", text: $textFieldFirstName)
                    .autocapitalization(.none)
                TextField("Achternaam", text: $textFieldLastName)
                    .autocapitalization(.none)
                TextField("Email", text: $textFieldEmail)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                SecureField("Wachtwoord", text: $textFieldPassword)
                    .autocapitalization(.none)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            Button {
                authViewModel.createUser(email: textFieldEmail, password: textFieldPassword, firstName: textFieldFirstName, lastName: textFieldLastName)
            } label: {
                Text("creëer account")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
                
            }.shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            NavigationLink {
                LoginView()
                    .navigationBarHidden(true)
            } label: {
                HStack {
                    Text("Heb je al een account?")
                        .font(.footnote)
                    Text("Log in")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(Color(.systemBlue))
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
