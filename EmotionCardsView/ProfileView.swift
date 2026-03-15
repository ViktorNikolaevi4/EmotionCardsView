import SwiftUI

struct ProfileView: View {
    var body: some View {
        List {
            Section("Профиль") {
                ProfileRow(title: "Аккаунт", icon: "person.circle")
                ProfileRow(title: "Язык: Русский", icon: "globe")
            }

            Section("Данные") {
                ProfileRow(title: "Сброс статистики", icon: "trash")
            }

            Section("Поддержка") {
                ProfileRow(title: "Написать разработчикам", icon: "envelope")
                ProfileRow(title: "О нас", icon: "info.circle")
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Профиль")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct ProfileRow: View {
    let title: String
    let icon: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .frame(width: 20)
                .foregroundStyle(.secondary)
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.footnote)
                .foregroundStyle(.tertiary)
        }
        .contentShape(Rectangle())
    }
}
