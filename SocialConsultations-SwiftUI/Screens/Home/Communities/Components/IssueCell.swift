//
//  IssueCell.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 25/11/2024.
//

import SwiftUI

struct IssueCell: View {
    
    let issue: Issue
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(issue.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Text(issue.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 2)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 2) {
                        Text(issue.createdAt.toPrettyDateString(showAge: false))
                            .font(.subheadline)
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("Status: \(issue.issueStatus)")
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                            .fontWeight(.semibold)
                            .padding(.trailing, 16)
                            
                    }
                    .padding(.top, 10)
                    
                }
                .padding(.leading, 4)
            }
        }
        .sectionShadowStyle()
    }
    
}

#Preview {
    IssueCell(issue: Issue(id: 5, title: "Barcelona new pavement in city center", description: "Barcelona has introduced a new pavement design in the city center, aimed at enhancing pedestrian safety and accessibility. The project incorporates sustainable materials and innovative patterns to improve aesthetics while reducing environmental impact. This initiative aligns with the city's commitment to modernizing urban infrastructure and promoting eco-friendly urban planning.", issueStatus: .inProgress, createdAt: "2024-11-25T17:19:13.8704545"))
}

