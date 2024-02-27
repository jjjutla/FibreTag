import SwiftUI

struct NFCFoundView: View {
    
    var clothes: Clothing
    
    @State private var historyData: [String: [String]] = [:]
    @Environment(\.presentationMode) var presentationMode
    
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
                    
                    Image(clothes.imageUrl)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 140)
                        .cornerRadius(20)
                        .padding(.bottom, 10)
                    
                    ForEach(0..<(historyData["0"]?.count ?? 0), id: \.self) { index in
                        ProgressView(title: historyData["0"]?[index] ?? "", dateTime: historyData["1"]?[index] ?? "", state: true)
                    }
                        
                    Divider()
                        .padding(.vertical, 10)
                    
                    
                        
                    HStack(spacing: 12) {
                        Text("Register ownership of the \(clothes.company) \(clothes.name)")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    .hCenter()
                    .padding(.leading, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(.black.opacity(0.7))
                            .frame(height: 60)
                    )
                    .padding(.top, 20)
                    .padding(.bottom, 50)
                    
                    Spacer()
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)
            }
            .navigationTitle(clothes.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 10, height: 10)
                            .padding(8)
                            .background(.gray)
                            .cornerRadius(50)
                    }
                }
            }
            .onAppear(perform: fetchHistory)
        }
    }
    
    func fetchHistory() {
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
    NFCFoundView(clothes: arClothes[0])
}
