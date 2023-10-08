import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Marketplace", systemImage: "storefront.fill")
                }
                
            AugmentView()
                .tabItem {
                    Label("Augment", systemImage: "arkit")
                }
            
            ScannerView()
                .tabItem {
                    Label("Scan", systemImage: "wifi")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabBarView()
}
