import SwiftUI

struct RandomCardGameView: View {
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
