import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Forgot Password?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)

                Text("Enter your email address to receive a password reset link.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.top, -10)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.headline)
                        .foregroundColor(.gray)
                    TextField("", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .customTextFieldStyle()
                }
                .padding(.top, 10)

                Button(action: resetPassword) {
                    HStack {
                        Spacer()
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Send")
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color("CustomRed"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .disabled(email.isEmpty || isLoading)

                Spacer()
            }
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.gray)
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Password Reset"), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                    if alertMessage == "A password reset link has been sent to your email." {
                        presentationMode.wrappedValue.dismiss()
                    }
                }))
            }
        }
        .navigationBarHidden(true)
    }

    private func resetPassword() {
        isLoading = true
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            isLoading = false
            if let error = error {
                alertMessage = "Error: \(error.localizedDescription)"
            } else {
                alertMessage = "A password reset link has been sent to your email."
            }
            showAlert = true
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
