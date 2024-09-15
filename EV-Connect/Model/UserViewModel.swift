import FirebaseFirestore
import FirebaseAuth

class UserViewModel: ObservableObject {
    @Published var user: UserModel?

    func fetchUserData() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { snapshot, error in
            if let data = snapshot?.data(), error == nil {
                let user = UserModel(
                    id: userId,
                    firstName: data["firstName"] as? String ?? "",
                    lastName: data["lastName"] as? String ?? "",
                    email: data["email"] as? String ?? ""
                )
                DispatchQueue.main.async {
                    self.user = user
                }
            }
        }
    }
}
