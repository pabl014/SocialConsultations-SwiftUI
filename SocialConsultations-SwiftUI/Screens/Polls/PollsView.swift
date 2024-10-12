//
//  PollsView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 09/10/2024.
//

import SwiftUI

struct PollsView: View {
    var body: some View {
        CardView()
            .navigationTitle("Polls")
    }
}

#Preview {
    NavigationStack {
        PollsView()
    }
}
