//
//  MarketplacePreviewView.swift
//  Vechain
//
//  Created by Artemiy Malyshau on 07/10/2023.
//

import SwiftUI

struct MarketplacePreviewView: View {
        
    var clothe: Clothing
    @State private var isLiked: Bool

    init(clothe: Clothing) {
        self.clothe = clothe
        _isLiked = State(initialValue: clothe.isLiked)
    }
    
    var body: some View {
        VStack {
            Image(clothe.imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 190)
                .cornerRadius(12)
                .overlay(
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(isLiked ? .red : .black)
                        .padding(8)
                        .background(.white.opacity(0.8))
                        .clipShape(Circle())
                        .offset(x: 50, y: -65)
                        .onTapGesture {
                            withAnimation {
                                isLiked.toggle()
                            }
                        }
                )
            
            HStack {
                VStack(alignment: .center) {
                    Text(clothe.name)
                        .font(.subheadline).bold()
                        .foregroundStyle(.black)
                    
                    Text(clothe.company)
                        .font(.caption)
                        .foregroundStyle(.black)

                }
            }
            
            VStack(alignment: .center) {
                Text(String(format: "US$ %.2f", clothe.price))
                    .font(.system(size: 15))
                    .foregroundStyle(.black)
            }
            .padding(.top, 1)
        }
    }
}

#Preview {
    MarketplacePreviewView(clothe: clothes[0])
}
