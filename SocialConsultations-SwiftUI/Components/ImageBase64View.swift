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
                            Image(systemName: "photo")
                                .resizable()
                                //.aspectRatio(contentMode: resizingMode)
                                .allowsHitTesting(false)
                        }
                    }
                }
                    .onAppear {
                        // Simulate loading process
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
    
     
    let img: String = Constants.example64
    // let badImg: String = Constants.bad64
    
    ImageBase64View(base64String: img)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(40)
        .padding(.vertical, 60)
        
}
