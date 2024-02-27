import SwiftUI
import Firebase
import FirebaseFirestore

// MARK: - Firebase Authentication Manager
class FirebaseAuthManager {
    static let shared = FirebaseAuthManager()

    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

// MARK: - Firestore Data Manager
class FirestoreDataManager {
    static let shared = FirestoreDataManager()
    private let db = Firestore.firestore()

    func fetchDocuments(completion: @escaping (Result<[Document], Error>) -> Void) {
        db.collection("documents").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let snapshot = snapshot {
                let documents = snapshot.documents.map { Document(documentSnapshot: $0) }
                completion(.success(documents))
            }
        }
    }
}

// MARK: - Document Model
struct Document {
    let name: String
    let company: String
    let price: Double
    let arModel: String
    let imageURL: String
    let cryptoWallet: String

    init(documentSnapshot: QueryDocumentSnapshot) {
        let data = documentSnapshot.data()
        self.name = data["name"] as? String ?? ""
        self.company = data["company"] as? String ?? ""
        self.price = data["price"] as? Double ?? 0.0
        self.arModel = data["armodel"] as? String ?? ""
        self.imageURL = data["image"] as? String ?? ""
        self.cryptoWallet = data["cryptoWallet"] as? String ?? ""
    }
}
