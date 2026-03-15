
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            GamesHomeView()
        }
    }
}

private struct GamesHomeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Карточки эмоций")
                        .font(.largeTitle.bold())
                    Text("Выберите игру и начните разговор о чувствах")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.bottom, 8)

                NavigationLink {
                    GameTabsView()
                } label: {
                    ModeCardView(
                        title: "Случайная карточка",
                        description: "Получите случайную эмоцию и обсудите её по шкале.",
                        backgroundColor: Color(red: 0.92, green: 0.96, blue: 1.0)
                    )
                }
                .buttonStyle(.plain)

                ModeCardView(
                    title: "Угадай эмоцию",
                    description: "Смотрите на карточку и попробуйте определить эмоцию.",
                    backgroundColor: Color(red: 1.0, green: 0.95, blue: 0.89)
                )

                ModeCardView(
                    title: "Советы родителю",
                    description: "Короткие подсказки, как мягко говорить с ребенком о чувствах.",
                    backgroundColor: Color(red: 0.91, green: 0.98, blue: 0.92)
                )
            }
            .padding(20)
        }
        .navigationTitle("Игры")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct ModeCardView: View {
    let title: String
    let description: String
    let backgroundColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 130, alignment: .leading)
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(backgroundColor)
        )
    }
}

private struct GameTabsView: View {
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

private struct PlaceholderTabView: View {
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

private struct RandomCardGameView: View {
    @State private var selectedCard: EmotionCard?
    @State private var isLoading = false
    @State private var intensity = 4.0
    @State private var isInnerBackVisible = false
    @State private var flipAxisY = 1.0

    var body: some View {
        VStack(spacing: 16) {
            if let card = selectedCard {
                EmotionCardView(
                    card: card,
                    intensity: $intensity,
                    isInnerBackVisible: isInnerBackVisible,
                    flipAxisY: flipAxisY
                )
                .frame(maxHeight: .infinity)
            } else {
                Text("Нажмите кнопку, чтобы получить случайную карточку.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Spacer(minLength: 0)

            Button {
                chooseCard()
            } label: {
                Text(selectedCard == nil ? "Начать игру" : "Выбрать карту")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .buttonStyle(.borderedProminent)
            .disabled(isLoading)
        }
        .padding()
        .navigationTitle("Случайная карточка")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func chooseCard() {
        guard !isLoading else { return }

        if selectedCard != nil {
            flipAxisY = 1
            withAnimation(.easeInOut(duration: 0.22)) {
                isInnerBackVisible = true
            }
        }
        isLoading = true

        Task {
            try? await Task.sleep(for: .seconds(2))
            selectedCard = EmotionCard.sampleCards.randomElement()
            intensity = 4

            if isInnerBackVisible {
                flipAxisY = -1
                withAnimation(.easeInOut(duration: 0.22)) {
                    isInnerBackVisible = false
                }
            }
            isLoading = false
        }
    }
}

private struct EmotionCardView: View {
    let card: EmotionCard
    @Binding var intensity: Double
    let isInnerBackVisible: Bool
    let flipAxisY: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color(.secondarySystemBackground))

                    Image(card.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .scaleEffect(1.04)
                        .padding(2)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(Color(red: 0.95, green: 0.80, blue: 0.20), lineWidth: 1.5)
                        )
                }
                .opacity(isInnerBackVisible ? 0 : 1)

                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(Color(red: 0.95, green: 0.80, blue: 0.20), lineWidth: 1.5)
                    )
                    .overlay {
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.12))
                                .frame(width: 120, height: 120)
                                .offset(x: -40, y: -40)

                            Circle()
                                .fill(Color.orange.opacity(0.12))
                                .frame(width: 90, height: 90)
                                .offset(x: 50, y: 30)

                            Image(systemName: "theatermasks.fill")
                                .font(.system(size: 54, weight: .semibold))
                                .foregroundStyle(Color.blue.opacity(0.7))
                        }
                    }
                    .opacity(isInnerBackVisible ? 1 : 0)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: flipAxisY, z: 0))
            }
            .rotation3DEffect(
                .degrees(isInnerBackVisible ? 180 : 0),
                axis: (x: 0, y: flipAxisY, z: 0),
                perspective: 0.7
            )
            .frame(width: 262, height: 440)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))

            VStack(alignment: .leading, spacing: 6) {
                Text("Шкала: \(Int(intensity)) / 7")
                    .font(.subheadline.weight(.semibold))
                Slider(value: $intensity, in: 1...7, step: 1)
            }
            .padding(.top, 6)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

private struct EmotionCard: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String

    static let sampleCards: [EmotionCard] = [
        EmotionCard(
            title: "Радость",
            description: "Легкость, энергия и желание делиться хорошим настроением.",
            imageName: "Радость"
        ),
        EmotionCard(
            title: "Спокойствие",
            description: "Внутренняя устойчивость, ровное дыхание и ясные мысли.",
            imageName: "Спокойствие"
        ),
        EmotionCard(
            title: "Удовлетворение",
            description: "Чувство внутренней полноты, когда результат совпадает с ожиданиями.",
            imageName: "Удовлетворение"
        )
    ]
}
