import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @StateObject private var authViewModel = AuthViewModel()

    @State var textFieldEmail = ""
    @State var textFieldPassword = ""
    
    var body: some View {
        VStack() {
            VStack(alignment: .leading) {
                HStack { Spacer() }
                
                Text("Hallo.")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("Welkom terug")
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
                TextField("Email", text: $textFieldEmail)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                SecureField("Wachtwoord", text: $textFieldPassword)
                    .autocapitalization(.none)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            HStack {
                Spacer()
                
                NavigationLink {
                    Text("Password forgot view")
                } label: {
                    Text("Wachtwoord vergeten?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.systemBlue))
                        .padding(.top)
                        .padding(.trailing, 24)
                }
            }
            Button {
                authViewModel.login(email: textFieldEmail, password: textFieldPassword)
            } label: {
                Text("Inloggen")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
                
            }.shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            NavigationLink {
                SignUpView()
                    .navigationBarHidden(true)
            } label: {
                HStack {
                    Text("Geen account?")
                        .font(.footnote)
                    Text("Meld je aan")
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
