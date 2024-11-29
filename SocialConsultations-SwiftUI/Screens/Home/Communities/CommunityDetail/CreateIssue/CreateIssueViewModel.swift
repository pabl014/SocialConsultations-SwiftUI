//
//  CreateIssueViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/11/2024.
//

import SwiftUI
import PhotosUI

@MainActor
final class CreateIssueViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var description: String = ""
    
    @Published var selectedPhotos: [PhotosPickerItem] = []
    @Published var images: [UIImage] = []
    
    @Published var selectedFiles: [URL] = []
    
    @Published var currentStateEndDate: Date = Date()
    
    @Published var isSubmitting: Bool = false
    
    let communityId: Int
    
    init(communityId: Int) {
        self.communityId = communityId
    }
    
    func addUniqueFiles(from urls: [URL]) {
        
        for url in urls {
            if !selectedFiles.contains(url) {
                selectedFiles.append(url)
            }
        }
    }
    
    public func loadSelectedPhotos(_ items: [PhotosPickerItem]) async {
        
        images.removeAll()
        
        for item in items {
            if let data = try? await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                images.append(image)
            }
        }
    }
    
    func prepareIssueData() async throws -> IssueForCreationDTO {
        
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
        
        return IssueForCreationDTO(
            title: title,
            description: description,
            communityId: communityId,
            files: imagesData + pdfFiles,
            currentStateEndDate: ISO8601DateFormatter().string(from: currentStateEndDate)
        )
    }
    
    func createIssue() async {
        
        isSubmitting = true
        
        do {
            let issueData = try await prepareIssueData()
            try await IssueManager.shared.createIssue(from: issueData)
        } catch {
            print("Error submitting issue: \(error.localizedDescription)")
        }
        
        isSubmitting = false
    }
    
    
}
