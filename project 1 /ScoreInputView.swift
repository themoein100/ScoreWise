import SwiftUI
import Charts

enum MarkingMode: String, CaseIterable, Identifiable {
    case withNegative = "با نمره منفی"
    case withoutNegative = "بدون نمره منفی"

    var id: String { self.rawValue }
}

struct ScoreInputView: View {
    let selectedAvatar: Avatar
    @Binding var name: String
    @Binding var age: String
    @Binding var isStudent: Bool

    @ObservedObject var scoreVM: ScoreViewModel

    @State private var correct: String = ""
    @State private var incorrect: String = ""
    @State private var unanswered: String = ""
    @State private var resultText: String = ""
    @State private var percentage: Int? = nil

    @State private var goToChart = false
    @State private var selectedMode: MarkingMode = .withNegative

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Text(selectedAvatar.emoji)
                        .font(.system(size: 72, weight: .bold))

                    Text("محاسبه نتیجه آزمون")
                        .font(.title)
                        .bold()

                    Text("نام: \(name)")
                    Text("سن: \(age)")
                    Text(isStudent ? "وضعیت: دانش‌آموز" : "وضعیت: غیر دانش‌آموز")

                    Group {
                        TextField("تعداد درست", text: $correct)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: correct) { _, _ in
                                correct = correct.filter { "0123456789".contains($0) }
                            }

                        TextField("تعداد غلط", text: $incorrect)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: incorrect) { _, _ in
                                incorrect = incorrect.filter { "0123456789".contains($0) }
                            }

                        TextField("تعداد نزده", text: $unanswered)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: unanswered) { _, _ in
                                unanswered = unanswered.filter { "0123456789".contains($0) }
                            }
                    }

                    // 🔶 منوی کشویی سفارشی با رنگ زرد برای گزینه انتخاب‌شده
                    HStack(spacing: 12) {
                        ForEach(MarkingMode.allCases) { mode in
                            Button(action: {
                                selectedMode = mode
                            }) {
                                Text(mode.rawValue)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(selectedMode == mode ? Color.yellow : Color.gray.opacity(0.2))
                                    .foregroundColor(.black)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    if let percent = percentage {
                        Text("\(percent)%")
                            .font(.largeTitle)
                            .foregroundColor(percent >= 50 ? .green : .red)
                            .font(.title)
                            .bold()
                    }

                    if !resultText.isEmpty {
                        Text(resultText)
                            .font(.largeTitle)
                            .foregroundColor(resultText == "ضعیف" ? .red : .primary)
                            .padding()
                    }
                        
                       

                    Button(action: calculateResult) {
                        Text("محاسبه نتیجه")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    if percentage != nil {
                        Button(action: {
                            goToChart = true
                        }) {
                            Text("رفتن به نمودار")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }

                    Button(action: resetForm) {
                        Text("ریست اطلاعات")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                  
                }
                .padding()
            }
            // Replaces the deprecated NavigationLink(isActive:) pattern.
            .navigationDestination(isPresented: $goToChart) {
                ScoreChartView(scoreVM: scoreVM)
            }
        }
    }

    private func calculateResult() {
        guard let correctInt = Int(correct),
              let incorrectInt = Int(incorrect),
              let unansweredInt = Int(unanswered) else {
            resultText = "لطفاً اعداد معتبر وارد کنید."
            percentage = nil
            return
        }

        let total = correctInt + incorrectInt + unansweredInt
        guard total > 0 else {
            resultText = "تعداد سوالات نمی‌تواند صفر باشد."
            percentage = nil
            return
        }

        let rawScore: Int
        switch selectedMode {
        case .withNegative:
            rawScore = (correctInt * 3) - incorrectInt
        case .withoutNegative:
            rawScore = correctInt * 3
        }

        let maxScore = total * 3
        let percent = max(0, min(100, Int(Double(rawScore) / Double(maxScore) * 100)))
        percentage = percent

        scoreVM.addScore(percent)

        switch percent {
        case 80...:
            resultText = "عالی ! 🌟"
        case 50..<80:
            resultText = "خوب ! 👍"
        case 0..<50:
            resultText = " متوسط"
        default:
            resultText = "ضعیف 😞"
        }
    }

    private func resetForm() {
        correct = ""
        incorrect = ""
        unanswered = ""
        percentage = nil
        resultText = ""
    }
}
