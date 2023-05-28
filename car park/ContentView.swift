import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseStorage

class FirebaseManager: NSObject {
    let storage: Storage
    
    static let shared = FirebaseManager()
    
    override init() {
        self.storage = Storage.storage()
        
        super.init()
    }
}

struct ContentView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                HomeView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            // Start listening to the authentication state
            authViewModel.listenToAuthState()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel()) // Inject the AuthViewModel as an environment object
    }
}
