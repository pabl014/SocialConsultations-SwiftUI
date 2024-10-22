//
//  ConsultationsView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 14/10/2024.
//

import SwiftUI

struct ConsultationsView: View {
    
    @State var selectedCat: CategoryContext = .current
    
    var body: some View {
        ScrollView(.vertical) {
            
            VStack(alignment: .leading) {
                ImageBase64View(base64String: Constants.example64)
                    .frame(height: 250)
                    .clipped()
                    .itemCornerRadius(20)
                
                
                // Content Section
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                        .font(.body)
                        .foregroundColor(.primary)
                        
                }
                .padding()
            }
            .background(Color(UIColor.secondarySystemBackground))
            .itemCornerRadius(20)
            .shadow(radius: 5)
            .padding()
            
            VStack(alignment: .leading) {
                Text("Consultations")
                    .bold()
                    .font(.title2)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.top, 10)
            //.padding(.bottom, -10)
            
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
            .padding(.horizontal)
            .padding(.top, 16)
            

            ForEach(0..<5) { _ in
                NavigationLink {
                    ConsultationDetailView()
                } label: {
                    HomeCellView()
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .navigationTitle("Society Title")
    }
}

#Preview {
    NavigationStack {
        ConsultationsView()
    }
}
