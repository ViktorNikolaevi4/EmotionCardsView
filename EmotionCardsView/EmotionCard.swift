import Foundation

struct EmotionCard: Identifiable {
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
