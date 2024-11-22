//
//  HeaderCardView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 11/10/2024.
//

import SwiftUI

struct HeaderCardView: View {
    
    var body: some View {
        VStack {
            ImageBase64View(base64String: Base64examples.example64)
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading){
                    Text("Society of City Center residents")
                        .font(.headline)
                        .lineLimit(2)
                        .padding(.bottom, 5)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack {
                    Text("Admin: Marcos Alonso")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Image(systemName: "message")
                        .foregroundColor(.gray)
                    Text("392")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .padding(.top, -8)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding(.horizontal)
        .frame(width: 300)
    }
}


#Preview {
    ScrollView(.horizontal) {
        HStack {
            ForEach(0..<5) { _ in
                HeaderCardView()
            }
        }
        .frame(height: 320)
    }
    .background(Color(.systemGroupedBackground))
    .scrollIndicators(.hidden)
    .edgesIgnoringSafeArea(.horizontal)
}
