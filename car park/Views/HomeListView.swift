//
//  SwiftUIView.swift
//  car park
//
//  Created by Daan Vanhekken on 02/11/2022.
//

import SwiftUI

struct HomeListView: View {
    @ObservedObject private var homeViewModel = HomeViewModel()
    @ObservedObject private var authViewModel = AuthViewModel()

    @State private var addHomeSheet: Bool = false
    
    var body: some View {
      NavigationView {
        ZStack {
            if homeViewModel.homes.count > 0 {
                List(homeViewModel.homes) { home in
                    HomeRowView(home: home)
                        .padding(.vertical, 4)
                }.navigationBarTitle("Homes")
            } else {
                VStack(alignment: .leading) {
                    Text("No homes found").font(.title)
                    Text("Add a new home here..").font(.subheadline)
                }
            }
            
            // Floating Button Panel
            VStack {
              Spacer()
              HStack {
                Spacer()
                HomeListActions(
                  primaryItem: HomeListActionItem(label: ""),
                  secondaryItems: [
                    HomeListActionItem(label: "house") {
                        self.addHomeSheet = true
                    }
                  ]
                )
                .padding()
              }
            }
          }
        }
          .onAppear {
              homeViewModel.fetchData()
          }
        .navigationBarTitle("Numbers")
          
        .sheet(isPresented: $addHomeSheet, content: {
            HomeAddView(addHomeSheet: $addHomeSheet)
        })
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView()
    }
}
