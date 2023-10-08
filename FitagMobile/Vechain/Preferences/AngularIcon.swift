import SwiftUI

struct AngularIcon: View {
    
    var icon : String
    var iconSize : Double = 36
    @Binding var selected : Bool
    @State var angel : Double = 0.0
    
    var body: some View {
        ZStack {
            if selected{
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .frame(width: iconSize,height: iconSize)
                    .backgroundAngularGradient(radius: 12, degree: angel)
                    .onAppear{
                        withAnimation(.linear(duration: 7)) {
                            angel += 350
                        }
                    }
            }
            
            RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color("tertiaryBackground").opacity(0.8))
                .frame(width: iconSize,height: iconSize)
                .overlay {
                    RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(Color("pink-gradient-2").opacity(0.5))
                }
                .overlay {
                    Image(systemName: icon)
                        .foregroundStyle(LinearGradient(colors: [Color("pink-gradient-1"),Color("pink-gradient-2")], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
        }
  
    }
}

#Preview {
    AngularIcon(icon: "house.fill", selected: .constant(false))
}
