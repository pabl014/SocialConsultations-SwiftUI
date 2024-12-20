//
//  SolutionsView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 03/12/2024.
//

import SwiftUI

struct SolutionsView: View {
    
    let issueId: Int
    let currentIssueStatus: IssueStatus
    
    @StateObject private var viewModel = SolutionsViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading solutions...")
            } else if viewModel.solutions.isEmpty {
                noSolutions
            } else {
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Current Status")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text("\(currentIssueStatus)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(currentIssueStatus == .voting ? .green : .blue)
                        
                        if currentIssueStatus != .voting {
                            HStack {
                                Text("Voting is disabled")
                                    .foregroundColor(.secondary)
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                            }
                        } else {
                            HStack {
                                Text("Voting is enabled!")
                                    .foregroundStyle(.green)
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .sectionShadowStyle()
                    
                    
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.solutions) { solution in
                            SolutionCell(
                                solution: solution,
                                currentUserId: viewModel.user?.id ?? -1,
                                currentIssueStatus: currentIssueStatus,
                                isHighestVoted: viewModel.isHighestVotedAndAfterVoting(solution, issueStatus: currentIssueStatus),
                                onVote: { votedSolution in
                                    await viewModel.voteForSolution(solutionId: votedSolution.id)
                                }
                            )
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchCurrentUser()
                await viewModel.fetchSolutions(for: issueId)
            }
        }
        .refreshable {
            Task {
                await viewModel.fetchSolutions(for: issueId)
            }
        }
        .alert(item: $viewModel.errorMessage) { errorMessage in
            Alert(
                title: Text("Error"),
                message: Text(errorMessage.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationTitle("Solutions")
    }
    
    var noSolutions: some View {
        ContentUnavailableView(
            "No solutions",
            systemImage: "xmark",
            description: Text("Solutions will be added by admin \n in the future")
        )
    }
}
