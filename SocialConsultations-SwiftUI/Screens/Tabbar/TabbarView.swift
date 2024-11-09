//
//  TabbarView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct TabbarView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        TabView {
            NavigationStack {
                // HomeView()
                //TestHomeView()
                CommunitiesView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(0)
            
            NavigationStack {
                ForumView()
            }
            .tabItem {
                Image(systemName: "bubble.left.and.bubble.right")
                Text("Forums")
            }
            .tag(1)
            
            NavigationStack {
                PollsView()
            }
            .tabItem {
                Image(systemName: "chart.pie.fill")
                Text("Polls")
            }
            .tag(2)
            
            NavigationStack {
                ProfileView(showSignInView: $showSignInView)
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            .tag(3)
            
        }
    }
}

#Preview {
    TabbarView(showSignInView: .constant(false))
}
