//
//  HomeAddView.swift
//  car park
//
//  Created by Daan Vanhekken on 06/11/2022.
//

import SwiftUI

struct CarAddView: View {
    @ObservedObject private var authViewModel = AuthViewModel()
    @ObservedObject private var homeViewModel = HomeViewModel()
    @ObservedObject private var carViewModel = CarViewModel()
    @ObservedObject private var carDataViewModel = CarDataViewModel()

    @Binding var addCarSheet: Bool
    
    init(authViewModel: AuthViewModel, homeViewModel: HomeViewModel, carViewModel: CarViewModel, addCarSheet: Binding<Bool>) {
        self.authViewModel = authViewModel
        self.homeViewModel = homeViewModel
        self.carViewModel = carViewModel
        self._addCarSheet = addCarSheet
    }
    
    @State private var brand: String = ""
    @State private var model: String = ""
    @State private var variant: String?
    @State private var year: Int = 0
    @State private var color: String = ""
    
    @State var shouldShowImagePicker = false
    
    @State var image: UIImage?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Button {
                    shouldShowImagePicker.toggle()
                } label: {
                    VStack {
                        if let image = self.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 128, height: 128)
                                .cornerRadius(64)
                        } else {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                                .foregroundColor(Color(.label))
                        }
                    }
                    .overlay(RoundedRectangle(cornerRadius: 64)
                                .stroke(Color.black, lineWidth: 3)
                    )
                    
                }
                Text(brand)
                    .frame(height: 50)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color(.systemBlue)),
                        alignment: .bottom
                    )
                Menu {
                   ForEach(carDataViewModel.makes) { make in
                       Button {
                           brand = make.makeName
                           carDataViewModel.fetchModels(makeId: make.makeId)
                       } label: {
                           Text(make.makeName)
                       }
                   }
               } label: {
                    Text("Brand")
               }

                Text(model)
                    .frame(height: 50)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color(.systemBlue)),
                        alignment: .bottom
                    )
                Menu {
                   ForEach(carDataViewModel.models) { modelObj in
                       Button {
                           model = modelObj.modelName
                       } label: {
                           Text(modelObj.modelName)
                       }
                   }
               } label: {
                    Text("Brand")
               }
                TextField("Variant", text: Binding<String>(
                    get: {
                        self.variant ?? "" // Return an empty string if variant is nil
                    },
                    set: {
                        self.variant = $0
                    }
                ))
                    .frame(height: 50)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color(.systemBlue)),
                        alignment: .bottom
                    )
                TextField("Year", value: $year, formatter: NumberFormatter())
                    .frame(height: 50)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color(.systemBlue)),
                        alignment: .bottom
                    )
                TextField("Color", text: $color)
                    .frame(height: 50)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color(.systemBlue)),
                        alignment: .bottom
                    )
            }
            .padding()
            .navigationBarTitle("Add car", displayMode: .inline) // This line sets the title
            .navigationBarItems(leading:
                Button(action: {
                    addCarSheet = false
                }, label: {
                    Text("Cancel")
                })
            )
            .navigationBarItems(trailing:
                Button(action: {
                    addCarSheet = false
                    let fileName = persistImageToStorage()
                    carViewModel.createCar(brand: brand, model: model, variant: variant, year: year, color: color, fileName: fileName)
                }, label: {
                    Text("Save")
                })
                .disabled(brand.isEmpty || model.isEmpty || color.isEmpty) // Disable the button if any of the fields are empty
            )
            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
                ImagePicker(image: $image)
            }
            .onAppear {
                carDataViewModel.fetchMakes()
            }
        }
    }
    
    private func persistImageToStorage() -> String {
        let filename = UUID().uuidString
        let newFileName = "\(filename).jpg"
        let ref = FirebaseManager.shared.storage.reference(withPath: newFileName)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return "none" }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                print(err)
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    print(err)
                    return
                }
            }
        }
        return newFileName
    }
}
