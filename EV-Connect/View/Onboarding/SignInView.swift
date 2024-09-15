import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var showAlert = false
    @State private var isPasswordVisible = false
    @Binding var isSignUp: Bool
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var showForgotPassword = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .customTextFieldStyle()
                
                ZStack {
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .customTextFieldStyle()
                                .disableAutocorrection(true)
                        } else {
                            SecureField("Password", text: $password)
                                .customTextFieldStyle()
                                .disableAutocorrection(true)
                        }
                    }
                    .frame(height: 44)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 16)
                    }
                }
                
                Button(action: signIn) {
                    Text("Sign In")
                }
                .customButtonStyle()
                
                HStack {
                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Forgot Password?")
                            .font(.footnote)
                            .foregroundColor(Color("CustomRed"))
                    }
                    Spacer()
                }
                
                HStack {
                    Text("Don't have an account?")
                    Button(action: {
                        withAnimation {
                            isSignUp = true
                        }
                    }) {
                        Text("Sign Up")
                            .foregroundColor(Color("CustomRed"))
                    }
                }
                .font(.footnote)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"),
                      message: Text(errorMessage),
                      dismissButton: .default(Text("OK")) {
                    errorMessage = ""
                })
            }
        }
        .padding(30)
    }
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter your email and password."
            showAlert = true
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .wrongPassword, .invalidEmail, .userNotFound:
                    errorMessage = "Incorrect email or password."
                default:
                    errorMessage = error.localizedDescription
                }
                showAlert = true
            }
        }
    }
}
