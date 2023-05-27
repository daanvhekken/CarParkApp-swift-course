//
//  SwiftUIView.swift
//  car park
//
//  Created by Daan Vanhekken on 02/11/2022.
//

import SwiftUI

struct CarListView: View {
    @ObservedObject private var carViewModel = CarViewModel()
    @State private var addCarSheet: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
              List(carViewModel.cars) { car in
                  VStack(alignment: .leading) {
                      Text(car.brand).font(.title)
                      Text(car.model).font(.subheadline)
                  }
              }.navigationBarTitle("Cars")
              .onAppear() {
                  self.carViewModel.fetchData()
              }
              
              // Floating Button Panel
              VStack {
                Spacer()
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
            }
          }
          .navigationBarTitle("Numbers")
            
          .sheet(isPresented: $addCarSheet, content: {
              CarAddView(addCarSheet: $addCarSheet)
          })
    }
}

struct CarListView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
    }
}
