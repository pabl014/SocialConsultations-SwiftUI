//
//  IssueViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 26/11/2024.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
final class IssueViewModel: ObservableObject {
    
    @Published var issue: IssueDetail?
    @Published var isLoading = false
    
    @Published var images: [UIImage] = []
    @Published var selectedFiles: [URL] = []
    
    @Published var title: String = ""
    @Published var description: String = ""
    
    @Published var isSubmitting: Bool = false
    
    func loadIssueDetails(from id: Int) async {
        
        isLoading = true
        
        do {
            let issue = try await IssueManager.shared.fetchIssueDetails(issueID: id)
            self.issue = issue
        } catch {
            print(error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func isGatheringInformation() -> Bool {
        
        guard let issue else { return false }
        return issue.issueStatus == .gatheringInformation
    }
    
    func isCompleted() -> Bool {
        
        guard let issue else { return false }
        return issue.issueStatus == .completed
    }
    
    func updateIssueStatus(newStatus: Int, completionDate: Date) async {
        
        guard let issue else { return }
        
        let dateString = completionDate.toISO8601String()
        
        guard dateString != issue.currentStateEndDate else {
            return
        }
        
        do {
            try await IssueManager.shared.updateIssueStatus(
                issueId: issue.id,
                newStatus: newStatus,
                completionDate: dateString
            )
        } catch {
            print("failed to update issue status in viewModel")
        }
    }
    
    func updateDescription(description: String) async {
        
        guard let issue else { return }
        
        do {
            try await IssueManager.shared.updateIssueDescription(
                issueId: issue.id,
                description: description
            )
        } catch {
            print("failed to update issue description in viewModel")
        }
    }
    
    func loadSelectedPhotos(_ items: [PhotosPickerItem]) async {
        
        images.removeAll()
        
        for item in items {
            if let data = try? await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                images.append(image)
            }
        }
    }
    
    func addUniqueFiles(from urls: [URL]) {
        
        for url in urls {
            if !selectedFiles.contains(url) {
                selectedFiles.append(url)
            }
        }
    }
    
    private func prepareSolutionData(for issueId: Int) async throws -> SolutionForCreationDTO {
        
        // Add images
        let imagesData = try images.map { image -> FileDataForCreationDto in
            
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                throw NSError(domain: "InvalidImage", code: -1, userInfo: nil)
            }
            return FileDataForCreationDto(
                data: imageData.base64EncodedString(),
                description: "Image",
                type: 0
            )
        }
        
        // Add files
        let pdfFiles = try selectedFiles.map { url -> FileDataForCreationDto in
            let data = try Data(contentsOf: url)
            return FileDataForCreationDto(
                data: data.base64EncodedString(),
                description: url.lastPathComponent,
                type: 1
            )
        }
        
        return SolutionForCreationDTO(
            title: title,
            description: description,
            files: imagesData + pdfFiles,
            issueId: issueId
        )
    }
    
    func createSolution() async {
        
        guard let issue else { return }
        
        isSubmitting = true
        
        do {
            let solutionData = try await prepareSolutionData(for: issue.id)
            try await IssueManager.shared.createSolution(from: solutionData)
        } catch {
            print("Error submitting issue: \(error.localizedDescription)")
        }
        
        isSubmitting = false
    }
}

        
