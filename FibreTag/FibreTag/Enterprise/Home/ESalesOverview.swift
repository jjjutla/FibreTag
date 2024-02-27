import SwiftUI
import Charts

struct ESalesOverview: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Text("Sales over Time")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.leading, 6)
                
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
                .frame(width: 330,height: 200)
                .chartYScale(domain: 40...100)
                .aspectRatio(contentMode: .fit)
                .padding()
            
                
                Spacer()
                
            }
            .padding(.horizontal, 16)
            .offset(y: -40)
        }
    }
}

struct DescriptionView: View {
    
    var description: String
    var number: Double
    
    var body: some View {
        VStack {
            HStack {
                Text(description)
                    .font(.system(size: 16))
                
                Spacer()
                
                Text((number > 0 ? "+" : "-") + "\(abs(number))%")
                    .font(.system(size: 20))
                    .foregroundColor(number > 0 ? .green : .red)
            }
            .padding()
        }
        .background(Color.black.opacity(0.03))
        .cornerRadius(14)
    }
}

#Preview {
    EHomeView()
//    ESalesOverview()
}
