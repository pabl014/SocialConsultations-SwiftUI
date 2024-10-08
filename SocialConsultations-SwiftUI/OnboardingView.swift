//
//  OnboardingView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 08/10/2024.
//

import SwiftUI

struct OnboardingView: View {
    
    var title: String = "Some title"
    var icon: String = "globe.europe.africa"
    var description: String = "Some description"
    var isLastScreen: Bool = false
    //var buttonAction: () -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.blue)
                
                Text(title)
                    .font(.title)
                    .bold()
                
                Text(description)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 40)
            
            VStack {
                Spacer()
                Button(isLastScreen ? "Let's Begin" : "Next") {
                    
                }
                .foregroundStyle(.white)
                .frame(width: 300, height: 50)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.bottom, 80)
            }
        }
    }
}

let onBoardingSteps: [OnboardingView] = [
    OnboardingView(title: "Welcome to Social Consultations app",
                   icon: "person.3.fill",
                   description: "Consult things from your city and region with others"
    ),
    
    OnboardingView(title: "Share your ideas and problems",
                   icon: "bubble.left.and.text.bubble.right.fill",
                   description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
    ),
    
    OnboardingView(title: "See results",
                   icon: "chart.bar.xaxis.ascending",
                   description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
    )
]


struct TabOnboardingView: View {
    
    @State private var currentTab: Int = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        TabView {
            OnboardingView(title: "Welcome to Social Consultations app",
                           icon: "person.3.fill",
                           description: "Consult things from your city and region with others"
            )
            
            OnboardingView(title: "Share your ideas and problems",
                           icon: "bubble.left.and.text.bubble.right.fill",
                           description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
            )
            
            OnboardingView(title: "See results",
                           icon: "chart.bar.xaxis.ascending",
                           description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
            )
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    TabOnboardingView()
}



