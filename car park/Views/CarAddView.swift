//
//  CarAddView.swift
//  car park
//
//  Created by Daan Vanhekken on 02/11/2022.
//

import SwiftUI

struct CarAddView: View {
    @Binding var addCarSheet: Bool
    
    @State var carBrands: [CarBrand] = carBrandData
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Modal")
                Menu {
                    ForEach(carBrands) { carBrand in
                        Button {
                        } label: {
//                            AsyncImage(url: URL(string: carBrand.logo))
                            Text(carBrand.name)
                        }
                    }
                } label: {
                     Text("Style")
                     Image(systemName: "tag.circle")
                }
            }
            .navigationBarItems(leading:
                Button {
                    addCarSheet = false
                } label: {
                    Text("Cancel")
                }
            )
            .navigationBarItems(trailing:
                Button {
                    addCarSheet = false
                } label: {
                    Text("Save")
                }
            )
        }
    }
}
