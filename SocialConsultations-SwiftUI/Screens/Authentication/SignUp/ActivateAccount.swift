//
//  ActivateAccount.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 30/10/2024.
//

import SwiftUI

struct ActivateAccount: View {
    
    @Binding var showSignInView: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Account Confirmation")
                .font(.largeTitle)
                .padding()
            
            Text("Please check your email to confirm your account.")
            
            Button("Back to Login") {
                dismiss()
            }
            .defaultButtonStyle()
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        ActivateAccount(showSignInView: .constant(false))
    }
}
