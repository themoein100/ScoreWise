import SwiftUI

struct HomeView: View {
    @AppStorage("hasSeenAvatarSelection") private var hasSeenAvatarSelection: Bool = false
    @AppStorage("selectedAvatarRawValue") private var storedAvatarRawValue: String = ""
    @StateObject private var scoreVM = ScoreViewModel()

    var body: some View {
        Group {
            if !hasSeenAvatarSelection {
                
                Text("در حال بارگذاری...")
            } else if let avatar = Avatar(rawValue: storedAvatarRawValue) {
                MainContentView(selectedAvatar: avatar, scoreVM: scoreVM)
            } else {
                Text("در حال بارگذاری...")
            }
        }
    }
}
