//
//  IssueView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 22/11/2024.
//

import SwiftUI

struct IssueView: View {
    
    let id: Int
    let isAdministrator: Bool
    
    @StateObject private var viewModel = IssueViewModel()
    
    var body: some View {
        ZStack {
            
            Color(hex: "#F2F2F2")
                .ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let issue = viewModel.issue {
                
                VStack {
                    IssueHeader(issue: issue)
                    
                    NavigationLink {
                        CommentsView(issueId: id, currentIssueStatus: issue.issueStatus)
                    } label: {
                        HStack {
                            VStack(spacing: 2) {
                                Text("See Discussion")
                                
                                Text("(\(issue.comments.count) comments)")
                                    .font(.footnote)
                            }
                            
                            Image(systemName: "chevron.right")
                            
                            
                            
                        }
                        .defaultButtonStyle()
                    }
                }
                
            }
        }
        .onAppear {
            Task {
                await viewModel.loadIssueDetails(from: id)
            }
        }
    }
}

#Preview {
    //IssueView(issue: Issue(id: 56, title: "siema", description: "elson", issueStatus: .inProgress, createdAt: "hghg"))
}


