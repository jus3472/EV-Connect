import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var showAlert = false
    @State private var isPasswordVisible = false
    @Binding var isSignUp: Bool
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("First Name", text: $firstName)
                .customTextFieldStyle()

            TextField("Last Name", text: $lastName)
                .customTextFieldStyle()

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .customTextFieldStyle()

            ZStack(alignment: .trailing) {
                if isPasswordVisible {
                    TextField("Password", text: $password)
                        .customTextFieldStyle()
                } else {
                    SecureField("Password", text: $password)
                        .customTextFieldStyle()
                }
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 16)
            }

            Button(action: signUp) {
                Text("Sign Up")
            }
            .customButtonStyle()

            HStack {
                Text("Already have an account?")
                Button(action: {
                    withAnimation {
                        isSignUp = false
                    }
                }) {
                    Text("Sign In")
                        .foregroundColor(Color("CustomRed"))
                }
            }
            .font(.footnote)
        }
        .padding(30)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"),
                  message: Text(errorMessage),
                  dismissButton: .default(Text("OK")) {
                      errorMessage = ""
                  })
        }
    }

    func signUp() {
        guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            showAlert = true
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .emailAlreadyInUse:
                    errorMessage = "Email is already in use."
                case .invalidEmail:
                    errorMessage = "Please enter a valid email."
                default:
                    errorMessage = error.localizedDescription
                }
                showAlert = true
            } else if let result = result {
                let db = Firestore.firestore()
                db.collection("users").document(result.user.uid).setData([
                    "firstName": firstName,
                    "lastName": lastName,
                    "email": email
                ]) { error in
                    if let error = error {
                        errorMessage = error.localizedDescription
                        showAlert = true
                    }
                }
            }
        }
    }
}
