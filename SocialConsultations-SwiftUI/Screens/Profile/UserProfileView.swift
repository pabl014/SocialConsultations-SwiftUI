//
//  UserProfileView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 19/11/2024.
//

import SwiftUI

struct UserProfileView: View {
    
    let userId: Int
    @StateObject private var viewModel = ProfileViewModel()
    @State private var isLoading = true
    
    var body: some View {
        VStack {
            if isLoading {
                LoadingView()
                    .frame(width: 100, height: 100)
                    .padding()
            } else {
                ImageBase64View(base64String: viewModel.user?.avatar?.data)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .padding()
                
                Text(viewModel.user?.name ?? "no name")
                Text(viewModel.user?.surname ?? "no surname")
                Text(viewModel.user?.email ?? "no email")
                Text(viewModel.user?.birthDate.toPrettyDateString() ?? "no birth date")
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchUser(with: userId) // Pobierz dane innego użytkownika
                isLoading = false
            }
        }
        .navigationTitle("User Profile")
    }
}

//#Preview {
//    UserProfileView(userId: MockData.mockUser.id)
//}

struct UserProfileView_Preview: View {
    var body: some View {
        VStack {
            ImageBase64View(base64String: MockData.mockUser1.avatar?.data)
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                .padding()
            
            Text(MockData.mockUser1.name)
            Text(MockData.mockUser1.surname)
            Text(MockData.mockUser1.email)
            Text(MockData.mockUser1.birthDate.toPrettyDateString())
        }
        .navigationTitle("User Profile")
    }
}

#Preview {
    UserProfileView_Preview()
}
