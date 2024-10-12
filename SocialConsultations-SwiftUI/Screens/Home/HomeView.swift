//
//  HomeView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State var selectedCat: CategoryContext = .current
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                
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
                .padding()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Near you")
                        .font(.headline)
                        .padding(.leading, 16)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<5) { _ in
                                HStack() {
                                    NavigationLink {
                                        ConsultationDetailView()
                                    } label: {
                                        HeaderCardView()
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                .frame(height: 320)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading) {
                    
                    Text("Last added")
                        .font(.headline)
                        .padding(.leading, 16)
                    
                    ForEach(0..<5) { _ in
                        NavigationLink {
                            ConsultationDetailView()
                        } label: {
                            HomeCellView()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 16)
                
            }
            .searchable(text: $searchText)
            
        }
        .navigationTitle("Consultations")
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
