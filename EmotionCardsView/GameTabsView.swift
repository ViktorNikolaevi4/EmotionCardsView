import SwiftUI

struct GameTabsView: View {
    @State private var selectedTab = 0
    @StateObject private var statsStore = EmotionStatsStore()

    var body: some View {
        TabView(selection: $selectedTab) {
            RandomCardGameView(statsStore: statsStore)
                .tabItem {
                    Label("Игра", systemImage: "gamecontroller.fill")
                }
                .tag(0)

            StatisticsView(statsStore: statsStore)
            .tabItem {
                Label("Статистика", systemImage: "chart.bar.fill")
            }
            .tag(1)

            PlaceholderTabView(
                title: "Награды",
                subtitle: "Этот режим добавим следующим шагом."
            )
            .tabItem {
                Label("Награды", systemImage: "rosette")
            }
            .tag(2)

            ProfileView()
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
