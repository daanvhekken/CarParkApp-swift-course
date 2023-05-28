//
//  SwiftUIView.swift
//  car park
//
//  Created by Daan Vanhekken on 02/11/2022.
//

import SwiftUI

struct CarListView: View {
    @ObservedObject private var carViewModel = CarViewModel()
    @ObservedObject private var authViewModel = AuthViewModel()
    @ObservedObject private var homeViewModel = HomeViewModel()
        
    init(authViewModel: AuthViewModel, homeViewModel: HomeViewModel) {
        self.authViewModel = authViewModel
        self.homeViewModel = homeViewModel
    }
    @State private var addCarSheet: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                if homeViewModel.homes.isEmpty {
                    Text("You have not added any homes yet. Create a home first and make this the default home by long pressing the home to start adding cars to it.")
                        .padding(20)
                } else {
                    if authViewModel.appUser.defaultHomeId == nil {
                        Text("You have to set a home the default home before you can start adding cars to it.")
                            .padding(20)
                    } else {
                        if carViewModel.cars.isEmpty {
                            Text("You have not added any cars yet. Start by clicking on the button below.")
                                .padding(20)
                            Button(action: {
                                self.addCarSheet = true
                            }) {
                              HStack(spacing: 8) {
                                  if let home = homeViewModel.homes.first(where: { $0.id == authViewModel.appUser.defaultHomeId }) {
                                      Text("Add a car to the home: " + home.homeName)
                                  }
                                
                                Image(systemName: "plus")
                                  .imageScale(.large)
                              }
                              .padding(.horizontal, 16)
                              .padding(.vertical, 10)
                              .background(
                                Capsule().strokeBorder(Color.black, lineWidth: 1.25)
                              )
                            } //: BUTTON
                            .accentColor(Color.black)
                        } else {
                            TabView {
                                ForEach(carViewModel.cars) { car in
                                    CarCardView(car: car)
                                }
                            }
                            .tabViewStyle(PageTabViewStyle())
                            .padding(.vertical, 20)
                        }
                    }
                }
            }
            .navigationBarTitle("Cars")
            .navigationBarItems(trailing:
                Button(action: {
                    self.addCarSheet = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .onAppear() {
                self.carViewModel.fetchData()
            }
            HStack {
              Spacer()
                CarListActions(
                primaryItem: CartListAction(label: ""),
                secondaryItems: [
                    CartListAction(label: "car") {
                      self.addCarSheet = true
                  }
                ]
              )
              .padding()
            }
        }
        .sheet(isPresented: $addCarSheet, content: {
            CarAddView(authViewModel: authViewModel, homeViewModel: homeViewModel, carViewModel: carViewModel, addCarSheet: $addCarSheet)
        })
    }
}
