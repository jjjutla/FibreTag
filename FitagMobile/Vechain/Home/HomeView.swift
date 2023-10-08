import SwiftUI

struct HomeView: View {
    let columns = [
        GridItem(.adaptive(minimum: 160))
    ]
    
    @State private var showARExperience = false
    @State private var selection: MarketOption = .buy
    
    enum MarketOption: String, CaseIterable {
        case buy = "Buy"
        case rent = "Rent"
    }

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    Picker("Options", selection: $selection) {
                        ForEach(MarketOption.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(clothes) { clo in
                            NavigationLink {
                                PreviewView(clothes: clo)
                            } label: {
                                MarketplacePreviewView(clothe: clo)
                            }
                        }
                    }
                }
                .padding(.top, 20)
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
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button { } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
