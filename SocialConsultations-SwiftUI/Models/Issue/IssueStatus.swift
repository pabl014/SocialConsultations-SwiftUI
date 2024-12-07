//
//  IssueStatus.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 25/11/2024.
//

import Foundation

enum IssueStatus: Int, Codable, CustomStringConvertible, CaseIterable {
    case gatheringInformation = 0   // commenting, adding files, adding solutions
    case voting = 1                 // commenting, adding files, voting
    case inProgress = 2             // commenting, adding files
    case feedbackCollection = 3     // commenting, adding files
    case completed = 4              // no more interactions allowed

    var description: String {
        switch self {
        case .gatheringInformation:
            return "Gathering Information"
        case .voting:
            return "Voting"
        case .inProgress:
            return "In Progress"
        case .feedbackCollection:
            return "Feedback Collection"
        case .completed:
            return "Completed"
        }
    }
}
