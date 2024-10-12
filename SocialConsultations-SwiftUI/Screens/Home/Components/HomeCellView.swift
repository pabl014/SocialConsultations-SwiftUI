//
//  HomeCellView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 11/10/2024.
//

import SwiftUI

struct HomeCellView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(radius: 5)
                    .frame(height: 150)
                
                HStack {
                    ImageBase64View(base64String: Constants.example64)
                        .frame(width: 120, height: 120)
                        .clipped()
                        .cornerRadius(10)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Wiejska street renovation")
                            .font(.headline)
                            .lineLimit(2)
                        
                        Text("Author: Javier Diaz")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.top, -1)
                    }
                    .padding(.leading, 5)
                    
                    Spacer()
                }
            }
            .padding()
        }
        //.background(Color(.systemGroupedBackground))
    }
}

#Preview {
    HomeCellView()
}
