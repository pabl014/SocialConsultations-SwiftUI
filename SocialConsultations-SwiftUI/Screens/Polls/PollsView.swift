//
//  PollsView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct PollsView: View {
    
    @State private var labelText: String = "Wiejska street renovation"
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
            
            VStack {
                ForEach(0..<3) { index in
                    NavigationLink {
                        PollsDetailView()
                    } label: {
                        cardView
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding()
        .searchable(text: $searchText)
        .navigationTitle("Polls")
    }
    
    
    var cardView: some View {
        VStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(labelText)
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
                        ImageBase64View(base64String: Base64examples.example64)
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
        PollsView()
    }
}
