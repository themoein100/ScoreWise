import SwiftUI

struct MainTabView: View {
    var selectedAvatar: Avatar
    @ObservedObject var scoreVM: ScoreViewModel
    @ObservedObject var appState: AppStateViewModel
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("خانه", systemImage: "house.fill")
                }
                .tag(0)

            SettingsView(appState: appState)
                .tabItem {
                    Label("تنظیمات", systemImage: "gearshape")
                }
                .tag(1)
            
            TutorialView()
                .tabItem {
                    Label("راهنما", systemImage: "questionmark.circle")
                }
                .tag(2)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
