//
//  GoldAnimatingGradientView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 07/12/2024.
//

import SwiftUI

struct GoldAnimatingGradientView: View {
    
    @State private var isAnimating = false

    // Golden colors
    let colors1 = (0..<9).map { _ in
        [Color(hex: "#FFD700"), Color(hex: "#FFECB3"), Color(hex: "#FFC107"), Color(hex: "#E4D00A")].randomElement()!
    }
    
    let colors2 = (0..<9).map { _ in
        [Color(hex: "#FFCC00"), Color(hex: "#FFF8DC"), Color(hex: "#DAA520"), Color(hex: "#FFD700")].randomElement()!
    }

    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                .init(x: 0, y: 0), .init(x: 0.5, y: 0), .init(x: 1, y: 0),
                .init(x: 0, y: 0.5), .init(x: 0.5, y: 0.5), .init(x: 1, y: 0.5),
                .init(x: 0, y: 1), .init(x: 0.5, y: 1), .init(x: 1, y: 1)
            ],
            colors: isAnimating ? colors1 : colors2
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 3).repeatForever()) {
                isAnimating.toggle()
            }
        }
    }
}

#Preview {
    GoldAnimatingGradientView()
        .ignoresSafeArea(.all)
}

