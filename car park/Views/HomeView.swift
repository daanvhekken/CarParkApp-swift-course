//
//  HomeView.swift
//  car park
//
//  Created by Daan Vanhekken on 30/10/2022.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var carViewModel = CarViewModel()
    
    @State private var selectedIndex = 0
    var body: some View {

        TabView {
            HomeListView()
                .onAppear {
                    self.selectedIndex = 0
                }
                .tag(0)
                .tabItem {
                    Image(systemName: "house")
                }
            CarListView()
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
