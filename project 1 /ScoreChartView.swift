import SwiftUI
import Charts

struct ScoreChartView: View {
    @ObservedObject var scoreVM: ScoreViewModel

    var body: some View {
        VStack {
            Text("نمودار نمرات شما")
                .font(.title)
                .padding()

            if scoreVM.scores.isEmpty {
                Text("هیچ نمره‌ای ثبت نشده است.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                Chart {
                    ForEach(scoreVM.scores) { entry in
                        LineMark(
                            x: .value("تاریخ", entry.date, unit: .day),
                            y: .value("نمره", entry.score)
                        )
                        .foregroundStyle(Color.blue)
                        PointMark(
                            x: .value("تاریخ", entry.date, unit: .day),
                            y: .value("نمره", entry.score)
                        )
                        .foregroundStyle(Color.red)
                    }
                }
                .frame(height: 300)
                .padding()
            }
        }
        .navigationTitle("نمودار نمرات")
        .navigationBarTitleDisplayMode(.inline)
    }
}
