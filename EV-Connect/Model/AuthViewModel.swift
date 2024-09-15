import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isSignedIn = false

    private var authListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        self.authListenerHandle = Auth.auth().addStateDidChangeListener { _, user in
            DispatchQueue.main.async {
                self.isSignedIn = user != nil
            }
        }
    }

    deinit {
        if let handle = authListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    func checkAuthenticationState() {
        self.isSignedIn = Auth.auth().currentUser != nil
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isSignedIn = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
