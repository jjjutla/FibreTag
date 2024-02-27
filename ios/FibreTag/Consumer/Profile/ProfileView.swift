import SwiftUI

struct ProfileView: View {
    
    @State private var showSettings = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.green.opacity(0.2), .white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        HStack(spacing: 14) {
                            Image("profilepic")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text("Artemiy Malyshau")
                                    .font(.system(size: 19)).bold()
                                
                                Text("amalyshau2002@gmail.com")
                                    .font(.caption)
                            }
                            
                            Spacer()
                        }
                        
                        HStack(spacing: 12) {
                            Text("Focused")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                        .hLeading()
                        .padding(.leading, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.black.opacity(0.6))
                                .frame(height: 46)
                        )
                        .padding(.top, 20)
                        
                        VStack(spacing: 4) {
                            HStack {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "map")
                                        .foregroundColor(.black.opacity(0.6))
                                }
                                .frame(width: 26)
                                
                                Text("London, UK")
                                    .foregroundColor(.black.opacity(0.6))
                                
                                Spacer()
                            }
                        }
                        .padding(.top, 16)
                        
                        HStack {
                            Text("Liked Items")
                                .font(.title3).bold()
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                        }
                        .padding(.top, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(clothes) { clo in
                                    AugmentMarketplaceView(clothe: clo)
                                        .containerRelativeFrame(.horizontal, count: 3, spacing: 4)
                                        .scrollTransition { content, phase in
                                            content
                                                .opacity(phase.isIdentity ? 1.0 : 0.1)
                                                .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3,
                                                             y: phase.isIdentity ? 1.0 : 0.3)
                                                .offset(y: phase.isIdentity ? 0 : 50)
                                        }
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .contentMargins(24, for: .scrollContent)
                        .scrollTargetBehavior(.viewAligned)
                        .hCenter()
                        .offset(x: -6, y: -24)
                        
                        VStack {
                            HStack {
                                Text("Past Orders")
                                    .font(.title3).bold()
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 14, height: 14)
                            }
                            .padding(.top, 10)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(arClothes) { clo in
                                        AugmentMarketplaceView(clothe: clo)
                                            .containerRelativeFrame(.horizontal, count: 3, spacing: 4)
                                            .scrollTransition { content, phase in
                                                content
                                                    .opacity(phase.isIdentity ? 1.0 : 0.1)
                                                    .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3,
                                                                 y: phase.isIdentity ? 1.0 : 0.3)
                                                    .offset(y: phase.isIdentity ? 0 : 50)
                                            }
                                    }
                                }
                                .scrollTargetLayout()
                            }
                            .contentMargins(24, for: .scrollContent)
                            .scrollTargetBehavior(.viewAligned)
                            .hCenter()
                            .offset(x: -6, y: -24)
                        }
                        .offset(y: -40)
                        
                        Button {
                            UserDefaults.standard.set(false, forKey: "signin")
                        } label: {
                            HStack(spacing: 12) {
                                Text("Sign Out")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(.white)
                            }
                            .hCenter()
                            .padding(.leading, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(.red)
                                    .frame(height: 50)
                            )
                            .padding(.top, 20)
                        }
                        .offset(y: -40)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsView(), isActive: $showSettings) {
                        EmptyView()
                    }

                    Button(action: {
                        showSettings.toggle()
                    }) {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
