//
//  ForumView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct ForumView: View {
    
    var body: some View {
        NavigationStack {
            Text("Forum View")
                .navigationTitle("Forum")
        }
        
    }

}

#Preview {
    NavigationStack {
        ForumView()
    }
}
