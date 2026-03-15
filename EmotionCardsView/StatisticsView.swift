import SwiftUI
import Combine

@MainActor
final class EmotionStatsStore: ObservableObject {
    @Published private var ratings: [String: Int] = [:]

    func setRating(for emotion: String, value: Int) {
        ratings[emotion] = value
    }

    func rating(for emotion: String) -> Int? {
        ratings[emotion]
    }

    var sortedRatings: [(emotion: String, value: Int)] {
        ratings
            .map { (emotion: $0.key, value: $0.value) }
            .sorted { $0.emotion < $1.emotion }
    }
}

struct StatisticsView: View {
    @ObservedObject var statsStore: EmotionStatsStore

    var body: some View {
        Group {
            if statsStore.sortedRatings.isEmpty {
                VStack(spacing: 10) {
                    Text("Статистика")
                        .font(.title2.weight(.semibold))
                    Text("Поставьте оценку карточке в игре, и она появится здесь.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(statsStore.sortedRatings, id: \.emotion) { item in
                    HStack {
                        Text(item.emotion)
                        Spacer()
                        Text("\(item.value) / 7")
                            .font(.headline)
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("Статистика")
        .navigationBarTitleDisplayMode(.inline)
    }
}
