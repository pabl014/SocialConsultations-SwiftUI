//
//  ExpandableSolutionsView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 26/11/2024.
//

import SwiftUI

struct ExpandableSolutionsView: View {
    
    @State private var isExpanded: Bool = false
    let solutions: [Solution]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button {
                withAnimation {
                    self.isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text("See Solutions")
                        .font(.headline)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }
                .padding()
            }
            
            // Rozwijana lista rozwiązań
            if isExpanded {
                ForEach(solutions, id: \.id) { solution in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(solution.title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(solution.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.white)
                    .itemCornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        
    }
}

#Preview {
    ExpandableSolutionsView(solutions: MockData.mockIssueDetail.solutions)
        .padding()
}
