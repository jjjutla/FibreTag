import SwiftUI

struct HomeView: View {
    let columns = [
        GridItem(.adaptive(minimum: 160))
    ]
    
    @State private var showARExperience = false
    @State private var showSettings = false
    @State private var searchString: String = ""

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    LazyVGrid(columns: columns, spacing: 18) {
                        ForEach(clothes) { clothe in
                             NavigationLink {
                                 PreviewView(item: clothe)
                             } label: {
                                 MarketplacePreviewView(item: clothe)
                             }
                         }
                    }
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 12)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.green.opacity(0.2), .white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .navigationTitle("Marketplace")
            .searchable(text: $searchString)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Image(systemName: "cart")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
