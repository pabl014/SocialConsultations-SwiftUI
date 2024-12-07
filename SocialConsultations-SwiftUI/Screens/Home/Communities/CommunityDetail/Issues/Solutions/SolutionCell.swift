//
//  SolutionCell.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 02/12/2024.
//

import SwiftUI

struct SolutionCell: View {
    
    let solution: Solution
    let currentUserId: Int
    let currentIssueStatus: IssueStatus
    let onVote: (Solution) async -> Bool
    
    @State private var selectedFile: FileData? = nil
    @State private var isVoted: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            VStack(alignment: .leading, spacing: 12) {
                
                Text(solution.title)
                    .font(.title2)
                    .lineLimit(1)
                    .bold()

                Text(solution.description)
                    .font(.body)
                
                Button(action: {
                    if currentIssueStatus == .voting && !isVoted {
                        Task {
                            let success = await onVote(solution)
                            if success {
                                isVoted = true // change to blue color if success
                            }
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.up")
                        Text("\(solution.userVotes.count)")
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 20)
                    .font(.title3)
                    .foregroundColor(isVoted ? .white : .black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(isVoted ? Color.blue : Color.gray.opacity(0.2))
                    .itemCornerRadius(10)
                }
                .disabled(isVoted || currentIssueStatus != .voting)
            }
            
            VStack {
                if !imageFiles.isEmpty {
                    TabView {
                        ForEach(imageFiles, id: \.id) { file in
                            ImageBase64View(base64String: file.data)
                                .clipped()
                                .itemCornerRadius(20)
                        }
                    }
                    .frame(width: 340, height: 200)
                    .tabViewStyle(PageTabViewStyle())
                    .itemCornerRadius(20)
                }
            }
            .padding(.horizontal, 4)
            
            VStack {
                if !documentFiles.isEmpty {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(documentFiles, id: \.id) { file in
                                Button {
                                    selectedFile = file
                                } label: {
                                    VStack(spacing: 8) {
                                        Image(systemName: "doc.text")
                                            .font(.system(size: 40))
                                            .foregroundColor(.blue)
                                        
                                        Text(file.description)
                                            .font(.footnote)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)
                                            .padding(.horizontal, 8)
                                    }
                                    .frame(width: 80, height: 80)
                                    .background(GradientTestGold())
                                    //.background(Color.white)
                                    .itemCornerRadius(8)
                                }
                                .sheet(item: $selectedFile) { file in
                                    PdfView(base64String: file.data)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .scrollIndicators(.visible)
                    .shadow(radius: 4)
                }
            }
            .padding(.top)
        }
        .padding()
        //.background(Color.white)
        .background(GradientTestGold())
        .itemCornerRadius(20)
        .shadow(color: Color.black.opacity(0.4), radius: 5)
        .padding(.horizontal, 16)
        .onAppear {
            isVoted = solution.userVotes.contains { $0.id == currentUserId }
        }
    }
    
    private var imageFiles: [FileData] {
        solution.files.filter { $0.type == 0 }
    }
    
    private var documentFiles: [FileData] {
        solution.files.filter { $0.type == 1 }
    }
}

#Preview {
    SolutionCell(
        solution: MockData.mockSolution1,
        currentUserId: 101,
        currentIssueStatus: .voting,
        onVote: { solution in
            print("Liked solution with id: \(solution.id)")
            return true 
        }
    )
}


