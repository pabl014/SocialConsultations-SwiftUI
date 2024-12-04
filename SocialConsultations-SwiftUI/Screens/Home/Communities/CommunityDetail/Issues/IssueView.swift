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
                    ScrollView {
                        IssueHeader(issue: issue)
                        
                        NavigationLink {
                            SolutionsView(issueId: id, currentIssueStatus: issue.issueStatus)
                        } label: {
                            VStack {
                                HStack {
                                    Text("See Solutions")
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .imageScale(.large)
                                        .foregroundStyle(.tint)
                                }
                                .padding()
                            }
                            .background(.white)
                            .itemCornerRadius(10)
                            .shadow(radius: 10)
                            .padding(.horizontal)
                            .padding(.bottom)
                        }
                    }
                    
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
        .refreshable {
            Task {
                await viewModel.loadIssueDetails(from: id)
            }
        }
    }
}

#Preview {
    //IssueView(issue: Issue(id: 56, title: "siema", description: "elson", issueStatus: .inProgress, createdAt: "hghg"))
}


