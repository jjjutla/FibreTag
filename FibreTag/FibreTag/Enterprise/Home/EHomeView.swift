import SwiftUI
import Charts

struct EHomeView: View {
    
    let linearGradient = LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.4),Color.accentColor.opacity(0)]),
                                        startPoint: .top,
                                        endPoint: .bottom)
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("FibreTag Sales")
                            .bold()
                        
                        Spacer()
                        
                        NavigationLink {
                            ESalesOverview()
                        } label: {
                            HStack {
                                Text("See more")
                                Image(systemName: "chevron.right")
                            }
                            .font(.caption)
                        }
                    }
                    Chart(salesData) {
                        LineMark(
                            x: .value("Month", $0.date),
                            y: .value("Sales", $0.sales)
                        )
                        .interpolationMethod(.cardinal)
                        
                        PointMark(
                            x: .value("Month", $0.date),
                            y: .value("Sales", $0.sales)
                        )
                        .interpolationMethod(.cardinal)
                    }
                    .frame(height: 200)
                    .chartYScale(domain: 40...100)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    
                    HStack {
                        Text("FibreTag Usage over Time")
                            .bold()
                        
                        Spacer()
                        
                        NavigationLink {
                            
                        } label: {
                            HStack {
                                Text("See more")
                                Image(systemName: "chevron.right")
                            }
                            .font(.caption)
                        }
                    }
                    Chart(usageData) {
                        LineMark(
                            x: .value("Month", $0.date),
                            y: .value("Usage", $0.usage)
                        )
                        .interpolationMethod(.cardinal)
                        
                        PointMark(
                            x: .value("Month", $0.date),
                            y: .value("Usage", $0.usage)
                        )
                        .interpolationMethod(.cardinal)
                    }
                    .frame(height: 200)
                    .chartYScale(domain: 70...140)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    EHomeView()
}
