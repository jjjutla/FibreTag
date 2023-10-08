import SwiftUI

struct PreviewView: View {
    
    var clothes: Clothing
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
                        .padding(.vertical, 20)
                    
                    HStack {
                        Text("Compliant with UNFCCC")
                            .font(.system(size: 17)).bold()
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                        }
                        .padding(.leading, 10)
                    }
                    .padding(12)
                    .background(.black.opacity(0.03))
                    .cornerRadius(14)
                    
                    HStack(spacing: 12) {
                        Text("Buy \(clothes.name)")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    .hCenter()
                    .padding(.leading, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.green.opacity(0.7))
                            .frame(height: 50)
                    )
                    .padding(.top, 20)
                    .padding(.bottom, 50)
                }
                .padding(.top, 10)
                .padding(.horizontal, 16)
            }
        }
        .navigationTitle(clothes.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: fetchHistory)
    }
    
    func fetchHistory() {
        let url = URL(string: "https://supplychain-fitag.vercel.app/api/getHistory")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let history = try? decoder.decode(HistoryResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.historyData = history.message
                    }
                }
            }
        }.resume()
    }
}

#Preview {
    PreviewView(clothes: clothes[0])
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
                    .font(.system(size: 17)).bold()
                
                Spacer()
                
                Text(dateTime)
                    .font(.caption)
                
                Button {
                    
                } label: {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(state ? .green : .red)
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
