import SwiftUI

struct HomeView: View {
    /// Passed down from the app so every tab shares one view model. HomeView used
    /// to create its own with @StateObject, which meant scores entered here landed
    /// in a different instance than the one the rest of the app was reading — the
    /// chart could stay empty no matter how many results were saved.
    @ObservedObject var scoreVM: ScoreViewModel

    @AppStorage("hasSeenAvatarSelection") private var hasSeenAvatarSelection: Bool = false
    @AppStorage("selectedAvatarRawValue") private var storedAvatarRawValue: String = ""

    var body: some View {
        Group {
            if hasSeenAvatarSelection, let avatar = Avatar(rawValue: storedAvatarRawValue) {
                MainContentView(selectedAvatar: avatar, scoreVM: scoreVM)
            } else {
                ProgressView()
            }
        }
    }
}
