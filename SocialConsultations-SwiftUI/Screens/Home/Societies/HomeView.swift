//
//  HomeView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State var searchText: String = ""
    
    var body: some View {

        ZStack {
            
            Color(hex: "#F2F2F2")
                .ignoresSafeArea()
            
            NavigationStack {
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Near you")
                            .font(.headline)
                            .padding(.leading, 16)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0..<5) { _ in
                                    HStack() {
                                        NavigationLink {
                                            ConsultationsView()
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
                            .padding(.bottom, 16)
                        
                        VStack(spacing: 16) {
                            ForEach(0..<5) { _ in
                                NavigationLink {
                                    ConsultationsView()
                                } label: {
                                    HomeCellView()
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding(.top, 16)
                    
                }
                .searchable(text: $searchText)
                
            }
            .navigationTitle("Societies")
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
