import SwiftUI

struct VoiceCommandView: View {
    var text: String
    
    @Binding var isOpen: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Image("wave")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack(alignment: .bottom, spacing: 20) {
                HStack {
                    Image(systemName: "mic.fill")
                        .font(.system(size: 24, weight: .semibold, design: .default))
                    
                    Text(text)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .padding(.bottom, 16)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isOpen = false
                    }
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 24, weight: .semibold, design: .default))
                        .frame(width: 64, height: 64)
                        .background(Color("CustomDarkGray"))
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                }
            }
            .padding()
            .background(Color("CustomGreen"))
            .foregroundColor(Color("CustomDarkGray"))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct VoiceCommandView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceCommandView(text: "Go to Eiffel Tower", isOpen: .constant(true))
    }
}
