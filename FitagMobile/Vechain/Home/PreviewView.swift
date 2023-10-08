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
                List {
                    ForEach(0..<(historyData["0"]?.count ?? 0), id: \.self) { index in
                        HStack {
                            Text(historyData["0"]?[index] ?? "")
                            Spacer()
                            Text(historyData["1"]?[index] ?? "")
                        }
                    }
                }
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
