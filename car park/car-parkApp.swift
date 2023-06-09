import SwiftUI
import Firebase

@main
struct car_parkApp: App {
    @StateObject var authViewModel = AuthViewModel()
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(authViewModel)
            }
        }
    }
}
