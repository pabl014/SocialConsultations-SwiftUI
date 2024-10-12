//
//  CardView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI


enum CategoryContext: CaseIterable, Identifiable {
    case current
    case finished
    
    var id: Self { self }
    
    var title: String {
        switch self {
            case .current: return "Current"
            case .finished: return "Finished"
        }
    }
}


struct CardView: View {
    
    @State private var labelText: String = "Kubanska street renovation"
    @State private var selectedCat: CategoryContext = .current
    @State private var searchText: String = ""
    
    var body: some View {

        ScrollView {
            VStack(spacing: 16) {
                Picker("Selected Category", selection: $selectedCat) {
                    ForEach(CategoryContext.allCases) { content in
                        Text(content.title)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 2)
                .padding(.bottom, 16)
            }
            cardView
            cardView
            cardView
            cardView
            cardView
        }
        .padding()
        .searchable(text: $searchText)
    }
    
    var cardView: some View {
        VStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("labelText")
                            .font(.title2.bold())
                            .foregroundStyle(.blue)
                        
                        Text("Hello, World!")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                }
                .padding(.bottom, 12)
                
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.secondary)
                    .frame(height: 140)
                    .overlay(
                        ImageBase64View(base64String: Constants.example64)
                            .clipped()
                            .cornerRadius(12)
                    )
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
        }
    }
}

#Preview {
    NavigationStack {
        CardView()
            .navigationTitle("Card View")
    }
    
}
