//
//  HomeAddView.swift
//  car park
//
//  Created by Daan Vanhekken on 06/11/2022.
//

import SwiftUI
import FirebaseStorage

class FirebaseManager: NSObject {
    let storage: Storage
    
    static let shared = FirebaseManager()
    
    override init() {
        self.storage = Storage.storage()
        
        super.init()
    }
    
}

struct HomeAddView: View {
    @StateObject private var homeViewMdel = HomeViewModel()
    @StateObject private var authViewModel = AuthViewModel()
    
    
    @Binding var addHomeSheet: Bool
    @State private var homeName = "" 
    @State private var city = ""
    @State private var street = ""
    @State private var house_number = ""
    @State private var postalCode = ""
    
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
                TextField("Enter home name", text: $homeName)
                    .frame(height: 50)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color(.systemBlue)),
                        alignment: .bottom
                    )

                TextField("City", text: $city)
                    .frame(height: 50)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color(.systemBlue)),
                        alignment: .bottom
                    )
                TextField("street", text: $street)
                    .frame(height: 50)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color(.systemBlue)),
                        alignment: .bottom
                    )
                TextField("House number", text: $house_number)
                    .frame(height: 50)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color(.systemBlue)),
                        alignment: .bottom
                    )
                TextField("Postal code", text: $postalCode)
                    .frame(height: 50)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color(.systemBlue)),
                        alignment: .bottom
                    )
            }
            .padding()
            .navigationBarTitle("Add Home", displayMode: .inline) // This line sets the title
            .navigationBarItems(leading:
                Button(action: {
                    addHomeSheet = false
                }, label: {
                    Text("Cancel")
                })
            )
            .navigationBarItems(trailing:
                Button(action: {
                    addHomeSheet = false
                    let fileName = persistImageToStorage()
                    print(fileName)
                homeViewMdel.createHome(homeName: homeName, city: city, street: street, postalCode: postalCode, houseNumber: house_number, fileName: fileName)
                }, label: {
                    Text("Save")
                })
            )
            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
                ImagePicker(image: $image)
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
//                self.err = "Failed to push image to Storage: \(err)"
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    print(err)
//                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }
                
//                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                print(url?.absoluteString)
            }
        }
        return newFileName
    }
}
