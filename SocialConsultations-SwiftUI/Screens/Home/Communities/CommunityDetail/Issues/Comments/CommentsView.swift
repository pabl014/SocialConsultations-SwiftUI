//
//  CommentsView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 26/11/2024.
//

import SwiftUI

struct CommentsView: View {
    
    @StateObject private var viewModel = CommentsViewModel()
    
    let issueId: Int
    let currentIssueStatus: IssueStatus
    
    @State private var isShowingAddCommentSheet = false
    @State private var newCommentText = ""
    @State private var selectedSortOrder = "Id%20desc"
    
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading comments...")
            } else if viewModel.comments.isEmpty {
                noComments
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.comments, id: \.id) { comment in
                            CommentCell(
                                comment: comment,
                                currentUserId: viewModel.user?.id ?? -1,
                                onLike: { likedComment in
                                    await viewModel.upvoteComment(commentId: likedComment.id)
                                }
                            )
                        }
                    }
                }
            }
            
            if currentIssueStatus != .completed {
                addComment
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchCurrentUser()
                await viewModel.fetchComments(for: issueId)
            }
        }
        .refreshable {
            Task {
                await viewModel.fetchComments(for: issueId)
            }
        }
        .alert(item: $viewModel.errorMessage) { errorMessage in
            Alert(
                title: Text("Error"),
                message: Text(errorMessage.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Picker("Sort", selection: $selectedSortOrder) {
                    Text("Newest").tag("Id%20desc")
                    Text("Oldest").tag("Id%20asc")
                }
                .onChange(of: selectedSortOrder) {
                    Task {
                        viewModel.sortOrder = selectedSortOrder
                        await viewModel.fetchComments(for: issueId)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
        }
        .navigationTitle("Comments")
    }
    
    
    var noComments: some View {
        ContentUnavailableView(
            "No comments",
            systemImage: "text.bubble",
            description: Text("Be the first to add a comment.")
        )
    }
    
    var addComment: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    isShowingAddCommentSheet.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                .padding()
                .sheet(isPresented: $isShowingAddCommentSheet) {
                    NavigationStack {
                        VStack {
                            TextEditor(text: $newCommentText)
                                .frame(height: 250)
                                .padding()
                                .itemCornerRadius(20)
                            
                            Spacer()
                        }
                        .navigationBarTitle("New respond", displayMode: .inline)
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("Submit") {
                                    Task {
                                        await viewModel.addComment(
                                            issueID: issueId,
                                            content: newCommentText,
                                            issueStatus: currentIssueStatus
                                        )
                                        newCommentText = ""
                                        isShowingAddCommentSheet = false
                                    }
                                }
                                .padding()
                                .disabled(newCommentText.isEmpty)
                            }
                            
                            ToolbarItem(placement: .topBarLeading) {
                                Button("Cancel") {
                                    isShowingAddCommentSheet = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    //CommentsView(issueId: <#Int#>, currentIssueStatus: <#IssueStatus#>)
}


