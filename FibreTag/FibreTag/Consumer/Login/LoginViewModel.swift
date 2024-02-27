import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    func signInWithEmailPassword(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let user = authResult?.user, error == nil else {
                // Handle error (e.g., show an alert)
                return
            }
            self?.createUserDocument(user)
        }
    }

    func signUpWithEmailPassword(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let user = authResult?.user, error == nil else {
                // Handle error
                return
            }
            self?.createUserDocument(user)
        }
    }



    // Function to create a user document in Firestore
    private func createUserDocument(_ user: User) {
        let db = Firestore.firestore()
        let userData: [String: Any] = [
            "uid": user.uid,
            "email": user.email ?? "",
            "displayName": user.displayName ?? ""
            // Add other user data you want to store
        ]
        db.collection("users").document(user.uid).setData(userData) { error in
            if let error = error {
                // Handle error (e.g., log the error)
            } else {
                // Success (e.g., navigate to the main app view)
            }
        }
    }
}
