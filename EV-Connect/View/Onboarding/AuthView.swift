import SwiftUI

struct AuthView: View {
    @Binding var isSignUp: Bool
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        if isSignUp {
            SignUpView(isSignUp: $isSignUp)
                .transition(.move(edge: .trailing))
                .environmentObject(authViewModel)
        } else {
            SignInView(isSignUp: $isSignUp)
                .transition(.move(edge: .leading))
                .environmentObject(authViewModel)
        }
    }
}
