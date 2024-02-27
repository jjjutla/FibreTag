import SwiftUI

struct ETabBarView: View {
    var body: some View {
        TabView {
            EHomeView()
                .tabItem {
                    Label("Marketplace", systemImage: "storefront.fill")
                }
                
            EWriteView()
                .tabItem {
                    Label("Write NFCs", systemImage: "qrcode.viewfinder")
                }
            
            ESettingView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ETabBarView()
}
