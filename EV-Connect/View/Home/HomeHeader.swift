import SwiftUI
import FirebaseAuth

struct HomeHeader: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showSignOutAlert = false

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Model 3".uppercased())
                    .font(.caption2)
                    .fontWeight(.medium)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .foregroundColor(Color.white)
                    .background(Color("CustomRed"))
                    .clipShape(Capsule())
                
                Text("Mach Five")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
            }
            
            Spacer()
            
            HStack {
                GeneralButton(icon: "lock.fill")
                Button(action: {
                    showSignOutAlert = true
                }) {
                    Image(systemName: "gear")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color("CustomDarkGray"))
                        .cornerRadius(8)
                }
                .alert(isPresented: $showSignOutAlert) {
                    Alert(
                        title: Text("Sign Out"),
                        message: Text("Are you sure you want to sign out?"),
                        primaryButton: .destructive(Text("Sign Out")) {
                            authViewModel.signOut()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
        .padding(.top)
    }
}
