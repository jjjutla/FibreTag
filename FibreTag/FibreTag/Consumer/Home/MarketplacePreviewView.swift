import SwiftUI

struct MarketplacePreviewView: View {
        
    var item: Clothing
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(item.imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: 170, height: 190)
                .cornerRadius(12)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.subheadline).bold()
                        .foregroundStyle(.black)
                    
                    Text(item.company)
                        .font(.caption)
                        .foregroundStyle(.black)

                }
            }
            .padding(.horizontal, 2)
            
            VStack(alignment: .leading) {
                Text(String(format: "US$ %.2f", item.price))
                    .font(.system(size: 15))
                    .foregroundStyle(.black)
            }
            .padding(.horizontal, 2)
        }
    }
}

#Preview {
    MarketplacePreviewView(item: clothes[0])
        .background(.red)
}
