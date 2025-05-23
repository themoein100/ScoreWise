import SwiftUI

@main
struct YourAppNameApp: App {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    @StateObject private var appState = AppStateViewModel()
    @StateObject private var scoreVM = ScoreViewModel()

    
    var body: some Scene {
        WindowGroup {
            if appState.hasSeenAvatarSelection,
               let avatar = Avatar(rawValue: appState.selectedAvatarRawValue) {
                MainTabView(
                    selectedAvatar: avatar,
                    scoreVM: scoreVM,
                    appState: appState
                )
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environment(\.layoutDirection, .rightToLeft)
            } else {
                AvatarSelectionView(appState: appState)
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                    .environment(\.layoutDirection, .rightToLeft)
            }
        }
    }
}
