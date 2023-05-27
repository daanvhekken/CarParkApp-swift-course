import SwiftUI
import FirebaseAuth
import FirebaseFirestore

final class AuthViewModel: ObservableObject {
    private let db = Firestore.firestore()
    @Published var userSession: FirebaseAuth.User?
    @Published var errorDescr = ""
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func createUser(email: String, password: String, firstName: String, lastName: String) {
        let userEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let userPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { result, error in
            if let error = error {
                self.errorDescr = error.localizedDescription
                Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
                    self.errorDescr = ""
                }
                print("Failed due to error:", error)
                return
            } else {
                self.db.collection("users").addDocument(data: [
                    "firstname": firstName,
                    "lastname": lastName,
                    "uid": result!.user.uid
                ]) { error in
                    if let error = error {
                        print("Failed due to error:", error)
                        // Todo show error
                    }
                }
                self.login(email: email, password: password)
                print("Successfully created account with ID: \(result?.user.uid ?? "")")
            }
        }
    }
    
    func login(email: String, password: String) {
        let userEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let userPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { result, error in
            if let error = error {
                print("Failed due to error:", error)
                self.errorDescr = error.localizedDescription
                Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
                    self.errorDescr = ""
                }
                return
            } else {
                guard let user = result?.user else { return }
                self.userSession = user
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch let signOutError as NSError {
            print("Error signing out:", signOutError)
        }
    }
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            if let user = user {
                // User is signed in
                self?.userSession = user
            } else {
                // User is signed out
                self?.userSession = nil
            }
        }
    }
}
