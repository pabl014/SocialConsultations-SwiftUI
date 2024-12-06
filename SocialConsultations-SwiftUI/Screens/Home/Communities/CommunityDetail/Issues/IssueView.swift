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
    
    @State private var isShowingEditStatusSheet = false
    @State private var isShowingEditDescriptionSheet = false
    @State private var isSHowingAddSolutionSheet = false
    
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
        .toolbar {
            if isAdministrator {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    if !viewModel.isCompleted() {
                        Button(action: {
                            isShowingEditStatusSheet.toggle()
                            print("Edit status tapped")
                        }) {
                            VStack {
                                Image(systemName: "pencil.circle")
                                Text("Status")
                                    .font(.footnote)
                            }
                        }
                    }

                    if !viewModel.isCompleted() {
                        Button(action: {
                            isShowingEditDescriptionSheet.toggle()
                            print("Edit description tapped")
                        }) {
                            VStack {
                                Image(systemName: "text.insert")
                                Text("Description")
                                    .font(.footnote)
                            }
                        }
                    }
                    
                    if viewModel.isGatheringInformation() {
                        Button(action: {
                            isSHowingAddSolutionSheet.toggle()
                            print("Add solution tapped")
                        }) {
                            VStack {
                                Image(systemName: "plus.circle")
                                Text("Solution")
                                    .font(.footnote)
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingEditStatusSheet) {
            EditIssueStatusSheet(viewModel: viewModel)
                .presentationDetents([.fraction(0.6)])
        }
        .sheet(isPresented: $isShowingEditDescriptionSheet) {
            EditIssueDescriptionSheet(viewModel: viewModel)
                .presentationDetents([.fraction(0.6)])
        }
        .sheet(isPresented: $isSHowingAddSolutionSheet) {
            AddSolutionSheet(viewModel: viewModel)
        }
    }
}

#Preview {
    //IssueView(issue: Issue(id: 56, title: "siema", description: "elson", issueStatus: .inProgress, createdAt: "hghg"))
}


