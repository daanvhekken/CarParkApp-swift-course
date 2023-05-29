import SwiftUI
import FirebaseAuth

// Create a shared instance of HomeViewModel
let authViewModel = AuthViewModel()
let homeViewModel = HomeViewModel()


struct HomeView: View {
    @State private var selectedIndex = 0
    
    let sharedAuthViewModel = authViewModel
    let sharedHomeViewModel = homeViewModel
    
    var body: some View {

        TabView {
            HomeListView(authViewModel: sharedAuthViewModel, homeViewModel: sharedHomeViewModel)
                .onAppear {
                    self.selectedIndex = 0
                }
                .tag(0)
                .tabItem {
                    Image(systemName: "house")
                }
            CarListView(authViewModel: sharedAuthViewModel, homeViewModel: sharedHomeViewModel)
                .onAppear {
                    self.selectedIndex = 1
                }
                .tag(1)
                .tabItem {
                    Image(systemName: "car.2")
                }

            SettingsView()
                .onAppear {
                    self.selectedIndex = 2
                }
                .tag(2)
                .tabItem {
                    Image(systemName: "gear")
                }
        }
        Button {
            authViewModel.signOut()
        } label: {
            Text("Signout")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
