//
//  CheckEmailView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 06/11/2024.
//

import SwiftUI

struct CheckEmailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Password Reset")
                .font(.largeTitle)
                .padding()
            
            Text("Please check your email to reset your password.")
            
            Button("Back") {
                dismiss()
            }
            .defaultButtonStyle()
            .padding()
        }
    }
}

#Preview {
    CheckEmailView()
}
