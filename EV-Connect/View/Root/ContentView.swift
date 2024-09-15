import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var isActive = false
    @StateObject private var authViewModel = AuthViewModel()
    @State private var isSignUp = false

    var body: some View {
        Group {
            if isActive {
                if authViewModel.isSignedIn {
                    HomeView()
                        .transition(.opacity)
                        .environmentObject(authViewModel)
                } else {
                    AuthView(isSignUp: $isSignUp)
                        .transition(.opacity)
                        .environmentObject(authViewModel)
                }
            } else {
                SplashView(isActive: $isActive)
            }
        }
        .onAppear {
            authViewModel.checkAuthenticationState()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
