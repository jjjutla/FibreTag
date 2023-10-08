//
//  ProfileView.swift
//  Vechain
//
//  Created by Artemiy Malyshau on 28/09/2023.
//

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
                            Image("dog")
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
                            Text("🚀 Focused")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                        .hLeading()
                        .padding(.leading, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.black.opacity(0.7))
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
                            
                            HStack {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "trophy")
                                        .foregroundColor(.black.opacity(0.6))
                                }
                                .frame(width: 26)
                                
                                HStack(spacing: -10) {
                                    Image("nft")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 34, height: 34)
                                        .clipShape(Circle())
                                        .padding(1)
                                        .background(.gray)
                                        .clipShape(Circle())
                                    
                                    Image("nft2")
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 37, height: 37)
                                        .padding(1)
                                        .background(.gray)
                                        .clipShape(Circle())
                                    
                                }
                                
                                Spacer()
                            }
                        }
                        .padding(.top, 16)
                        
                        HStack {
                            Text("Your liked Items")
                                .font(.title3).bold()
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
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
                                Text("Your past Orders")
                                    .font(.title3).bold()
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                            }
                            .padding(.top, 10)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(clothes.reversed()) { clo in
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
