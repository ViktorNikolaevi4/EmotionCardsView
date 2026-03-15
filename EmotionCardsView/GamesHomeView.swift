import SwiftUI

struct GamesHomeView: View {
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

struct ModeCardView: View {
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
