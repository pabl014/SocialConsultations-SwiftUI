//
//  IssueHeader.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 26/11/2024.
//

import SwiftUI

struct IssueHeader: View {
    
    let issue: IssueDetail
    @State private var selectedFile: FileData? = nil
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                VStack(alignment: .leading, spacing: 16) {
                    Text(issue.title)
                        .font(.title)
                        .bold()
                    Text(issue.description)
                        .font(.body)
                    
                    Text("Created at: \(issue.createdAt.toPrettyDateString(showAge: false))")
                        .font(.footnote)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .sectionShadowStyle()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Current Status")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text("\(issue.issueStatus)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    HStack {
                        Text("Ends on:")
                            .foregroundColor(.secondary)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Text(issue.currentStateEndDate.toPrettyDateString(showAge: false))
                            .foregroundColor(.secondary)
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .sectionShadowStyle()
                
                
                
                if !imageFiles.isEmpty {
                    
                    Images
                    
                    TabView {
                        ForEach(imageFiles, id: \.id) { file in
                            ImageBase64View(base64String: file.data)
                                .frame(height: 250)
                                .clipped()
                                .itemCornerRadius(20)
                        }
                    }
                    .frame(height: 250)
                    .tabViewStyle(PageTabViewStyle())
                    .itemCornerRadius(20)
                    .padding()
                }
                
                if !documentFiles.isEmpty {
                    
                    Documents
                    
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(documentFiles, id: \.id) { file in
                                
                                Button {
                                    selectedFile = file
                                } label: {
                                    VStack(spacing: 4) {
                                        Image(systemName: "text.document.fill")
                                            .font(.system(size: 60))
                                            .padding(.top)
                                        
                                        Text(file.description)
                                            .font(.subheadline)
                                            .lineLimit(2)
                                            .padding()
                                    }
                                    .frame(width: 120, height: 100)
                                    .sectionShadowStyle()
                                    
                                }
                                .sheet(item: $selectedFile) { file in
                                    PdfView(base64String: file.data)
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
                ExpandableSolutionsView(solutions: issue.solutions)
                    .padding()
            }
        }
    }
    
    private var imageFiles: [FileData] {
        issue.files.filter { $0.type == 0 }
    }
    
    private var documentFiles: [FileData] {
        issue.files.filter { $0.type == 1 }
    }
    
    var Images: some View {
        VStack(alignment: .leading) {
            Text("Images")
                .bold()
                .font(.title2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.top, 10)
    }
    
    var Documents: some View {
        VStack(alignment: .leading) {
            Text("Documents")
                .bold()
                .font(.title2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.top, 10)
    }
}

#Preview {
    IssueHeader(issue: MockData.mockIssueDetail)
}


