import SwiftUI
import Foundation


enum Avatar: String, CaseIterable, Identifiable {
    case bear = "🐻"
    case cat = "🐱"
    case panda = "🐼"
    case robot = "🤖"

    var id: String { self.rawValue }
    var emoji: String { self.rawValue }
}

struct ScoreEntry: Identifiable {
    let id = UUID()
    let date: Date
    let score: Int
}


class ScoreViewModel: ObservableObject {
    @Published var scores: [ScoreEntry] = []

    func addScore(_ score: Int) {
        let newEntry = ScoreEntry(date: Date(), score: score)
        scores.append(newEntry)
    }
}


class AppStateViewModel: ObservableObject {
    @AppStorage("hasSeenAvatarSelection") var hasSeenAvatarSelection: Bool = false {
        didSet { objectWillChange.send() }
    }

    @AppStorage("selectedAvatarRawValue") var selectedAvatarRawValue: String = "" {
        didSet { objectWillChange.send() }
    }
}


struct AvatarSelectionView: View {
    @ObservedObject var appState: AppStateViewModel
    @State private var selectedAvatar: Avatar? = nil

    var body: some View {
        VStack(spacing: 30) {
            Text("انتخاب آواتار")
                .font(.title)
                .bold()

            HStack(spacing: 25) {
                ForEach(Avatar.allCases) { avatar in
                    Text(avatar.emoji)
                        .font(.system(size: 50))
                        .padding(12)
                        .background(selectedAvatar == avatar ? Color.blue.opacity(0.3) : Color.gray.opacity(0.1))
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(selectedAvatar == avatar ? Color.blue : Color.clear, lineWidth: 2)
                        )
                        .onTapGesture {
                            selectedAvatar = avatar
                        }
                }
            }

            Button("تأیید و ادامه") {
                if let avatar = selectedAvatar {
                    appState.selectedAvatarRawValue = avatar.rawValue
                    appState.hasSeenAvatarSelection = true
                }
            }
            .padding()
            .frame(maxWidth: 200)
            .background(selectedAvatar != nil ? Color.green : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(12)
            .disabled(selectedAvatar == nil)
        }
        .padding()
    }
}
