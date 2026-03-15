import SwiftUI

struct EmotionCardView: View {
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
