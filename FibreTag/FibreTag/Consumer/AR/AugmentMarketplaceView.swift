import SwiftUI

struct AugmentMarketplaceView: View {
    
    var clothe: Clothing
    
    var body: some View {
        VStack {
            Image(clothe.imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .cornerRadius(12)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(clothe.name)
                        .font(.subheadline).bold()
                    
                    Spacer()
                }
                
                Text(clothe.company)
                    .font(.caption)
            }

            .padding(.top, 1)
        }
    }
}

#Preview {
    AugmentMarketplaceView(clothe: clothes[1])
}
