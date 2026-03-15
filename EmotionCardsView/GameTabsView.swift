import SwiftUI

struct GameTabsView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            RandomCardGameView()
                .tabItem {
                    Label("Игра", systemImage: "gamecontroller.fill")
                }
                .tag(0)

            PlaceholderTabView(
                title: "Угадай эмоцию",
                subtitle: "Этот режим добавим следующим шагом."
            )
            .tabItem {
                Label("Угадай", systemImage: "questionmark.circle")
            }
            .tag(1)

            PlaceholderTabView(
                title: "Советы родителю",
                subtitle: "Этот режим добавим следующим шагом."
            )
            .tabItem {
                Label("Советы", systemImage: "lightbulb")
            }
            .tag(2)

            PlaceholderTabView(
                title: "Профиль",
                subtitle: "Раздел в разработке."
            )
            .tabItem {
                Label("Профиль", systemImage: "person.crop.circle")
            }
            .tag(3)
        }
        .navigationBarBackButtonHidden(false)
    }
}

struct PlaceholderTabView: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.title2.weight(.semibold))
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
