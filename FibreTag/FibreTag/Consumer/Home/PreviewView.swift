import SwiftUI
import UIKit

struct PreviewView: View {
    
    var item: Clothing
    @State private var historyData: [String: [String]] = [:]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.green.opacity(0.2), .white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView(showsIndicators: false) {
                    Image(item.imageUrl)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 140)
                        .cornerRadius(20)
                        .padding(.bottom, 10)
                    
                    Text("Buy")
                        .font(.title2).bold()
                        .hLeading()
                    
                    Text("Upon purchasing this item, you will receive a digital twin NFT that will be accessible through the interactive AR view.")
                        .font(.caption)
                        .hLeading()
                        .padding(.bottom, 8)
                    
                    HStack(spacing: 8) {
                        Image("nike")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .cornerRadius(6)
                        
                        Text("Purchase on ") + Text("nike.com").underline()
                            .font(.system(size: 17))
                        
                        Spacer()
                        
                        Button {
                            // EDIT URL
                            let urlString = "https://www.apple.com"

                            if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        .padding(.leading, 10)
                    }
                    .padding(12)
                    .background(.black.opacity(0.03))
                    .cornerRadius(14)
                    
                    HStack(spacing: 8) {
                        Image("stockx")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .cornerRadius(6)
                        
                        Text("Purchase on ") + Text("stockx.com").underline()
                            .font(.system(size: 17))
                        
                        Spacer()
                        
                        Button {
                            let urlString = "https://www.apple.com"

                            if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        .padding(.leading, 10)
                    }
                    .padding(12)
                    .background(.black.opacity(0.03))
                    .cornerRadius(14)
                    
                    HStack(spacing: 8) {
                        Image("mrporter")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .cornerRadius(6)
                        
                        Text("Purchase on ") + Text("mrporter.com").underline()
                            .font(.system(size: 17))
                        
                        Spacer()
                        
                        Button {
                            let urlString = "https://www.apple.com"

                            if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        .padding(.leading, 10)
                    }
                    .padding(12)
                    .background(.black.opacity(0.03))
                    .cornerRadius(14)
                    
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("Product History")
                        .font(.title2).bold()
                        .hLeading()
                    
                    Text("View the product history of this item below, this data is immutable and ensures that you, as our customer, are aware of where and when this product was made, and that it was verified by FibreTag.")
                        .font(.caption)
                        .hLeading()
                        .padding(.bottom, 8)
                    
                    ForEach(0..<(historyData["0"]?.count ?? 0), id: \.self) { index in
                        ProgressView(title: historyData["0"]?[index] ?? "", dateTime: historyData["1"]?[index] ?? "", state: true)
                    }
                    
                }
                .padding(.top, 10)
                .padding(.horizontal, 16)
            }
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: fetchHistory)
    }
    
    func fetchHistory() {
        // Instead of fetching from an API, we're creating mock data directly
        let mockHistoryData: [String: [String]] = [
            "0": ["Order Received", "Garments Produced", "Prepared for Delivery", "Out for Delivery", "Verified by FibreTag"],
            "1": ["01-03-2024 09:00", "02-03-2024 12:00", "03-03-2024 15:30", "04-03-2024 15:30", "05-03-2024 15:30"]
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.historyData = mockHistoryData
        }
    }
}

#Preview {
    PreviewView(item: clothes[0])
}

struct HistoryResponse: Decodable {
    var message: [String: [String]]
}

struct ProgressView: View {
    
    var title: String
    var dateTime: String
    var state: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            
            HStack {
                Text(title)
                    .font(.system(size: 16))
                
                Spacer()
                
                Text(dateTime)
                    .font(.caption)
                
                Button {
                    
                } label: {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                }
                .padding(.leading, 10)
            }
            .padding(.horizontal, 6)
        }
        .padding(12)
        .background(.black.opacity(0.03))
        .cornerRadius(14)

    }
}

#Preview {
    ProgressView(title: "Product created", dateTime: "22-19-2023 14:23:12", state: true)
}
