import SwiftUI

struct SpinnerProgressView: View {
    @State private var isSpinning = false
    
    var color: Color = .blueUniversal
    var lineWidth: CGFloat = 4
    var size: CGFloat = 48
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.75)
            .stroke(
                color,
                style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
            )
            .frame(width: size, height: size)
            .rotationEffect(.degrees(isSpinning ? 360 : 0))
            .animation(
                .linear(duration: 1).repeatForever(autoreverses: false),
                value: isSpinning
            )
            .onAppear {
                isSpinning = true
            }
    }
}

#Preview {
    SpinnerProgressView()
}
