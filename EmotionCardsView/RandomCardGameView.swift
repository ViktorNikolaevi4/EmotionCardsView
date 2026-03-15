import SwiftUI

struct RandomCardGameView: View {
    @ObservedObject var statsStore: EmotionStatsStore
    @State private var selectedCard: EmotionCard?
    @State private var isLoading = false
    @State private var intensity = 1.0
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
                .transition(.opacity.combined(with: .scale(scale: 0.96)))
            } else {
                Text("Нажмите кнопку, чтобы получить случайную карточку.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Spacer(minLength: 0)

            Button {
                chooseCard()
            } label: {
                Text(selectedCard == nil ? "Начать игру" : "Новая карта")
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
        .onChange(of: intensity) { _, newValue in
            guard let card = selectedCard else { return }
            statsStore.setRating(for: card.title, value: Int(newValue))
        }
    }

    private func chooseCard() {
        guard !isLoading else { return }
        let isFirstCardReveal = selectedCard == nil

        if let currentCard = selectedCard {
            statsStore.setRating(for: currentCard.title, value: Int(intensity))
        }

        if selectedCard != nil {
            flipAxisY = 1
            withAnimation(.easeInOut(duration: 0.22)) {
                isInnerBackVisible = true
            }
        }
        isLoading = true

        Task {
            try? await Task.sleep(for: .seconds(2))
            let nextCard = EmotionCard.sampleCards.randomElement()

            if isFirstCardReveal {
                withAnimation(.easeInOut(duration: 0.35)) {
                    selectedCard = nextCard
                }
            } else {
                selectedCard = nextCard
            }
            if let title = selectedCard?.title {
                intensity = Double(statsStore.rating(for: title) ?? 1)
                statsStore.setRating(for: title, value: Int(intensity))
            } else {
                intensity = 1
            }

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
