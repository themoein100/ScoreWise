import SwiftUI

struct SettingsView: View {
    @ObservedObject var appState: AppStateViewModel

    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        Form {
            Toggle("حالت شب", isOn: $isDarkMode)

            Button("ریست برنامه") {
                appState.hasSeenAvatarSelection = false
                appState.selectedAvatarRawValue = ""
            }
            .foregroundColor(.red)

            Section(header: Text("درباره برنامه")) {
                HStack {
                    Text("نسخه")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.gray)
                }

                HStack {
                    Text("توسعه‌دهنده")
                    Spacer()
                    Text("Moein")
                        .foregroundColor(.gray)
                }

                HStack {
                    Text("ساخته‌شده با")
                    Spacer()
                    Text("SwiftUI")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("تنظیمات")
    }
}
