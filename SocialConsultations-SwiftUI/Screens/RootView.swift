//
//  RootView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = true
    
    var body: some View {
        ZStack {
            if !showSignInView {
                TabbarView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
//            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
//            self.showSignInView = authUser == nil ? true : false
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
