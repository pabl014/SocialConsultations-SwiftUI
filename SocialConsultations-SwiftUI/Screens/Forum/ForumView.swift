//
//  ForumView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct ForumView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<20) { _ in
                    NavigationLink {
                        ForumDetailView()
                    } label: {
                        ForumCell()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Forums")
        }
    }
}

#Preview {
    NavigationStack {
        ForumView()
    }
}
