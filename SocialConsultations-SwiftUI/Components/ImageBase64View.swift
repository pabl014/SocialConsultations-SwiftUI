//
//  ImageBase64View.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 11/10/2024.
//

import SwiftUI

struct ImageBase64View: View {
    
    let base64String: String?
    @State private var isLoading = true
    var resizingMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay(
                ZStack {
                    if isLoading {
                        LoadingView()
                    } else {
                        if let base64String,
                           let uiImage = decodeBase64Image(from: base64String) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: resizingMode)
                                .allowsHitTesting(false)
                        } else {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.2))
                                .overlay(
                                    Text("No Image")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                )
                                .aspectRatio(contentMode: resizingMode)
                                .allowsHitTesting(false)
                        }
                    }
                }
                    .onAppear {
                        // Simulate loading process
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isLoading = false
                        }
                    }
            )
    }
    
    private func decodeBase64Image(from base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String),
              let uiImage = UIImage(data: imageData) else {
            return nil
        }
        return uiImage
    }
}


struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(1.5)
    }
}

#Preview {
    
    let img: String = Base64examples.example64
    let img2: String = Base64examples.example64_2
    let img3: String = Base64examples.example64_3
    let badImg: String = Base64examples.bad64
    
    ScrollView(.horizontal){
        HStack {
            ImageBase64View(base64String: img3)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .frame(width: 300, height: 300)
                .padding(10)
                .padding(.vertical, 60)
            
            ImageBase64View(base64String: badImg)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .frame(width: 300, height: 300)
                .padding(10)
                .padding(.vertical, 60)
            
            ImageBase64View(base64String: img)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .frame(width: 300, height: 300)
                .padding(10)
                .padding(.vertical, 60)
            
            
            ImageBase64View(base64String: img2)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .frame(width: 300, height: 300)
                .padding(10)
                .padding(.vertical, 60)
        }
        
    }
}
