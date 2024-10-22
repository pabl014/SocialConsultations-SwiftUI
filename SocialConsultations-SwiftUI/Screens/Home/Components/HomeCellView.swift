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
                        .itemCornerRadius(10)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Bialystok Residents Society")
                            .font(.headline)
                            .lineLimit(2)
                        
                        Text("Admin: Javier Diaz")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.top, 2)
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
