//
//  CreateCommunityViewModel.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 30/11/2024.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
final class CreateCommunityViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var description: String = ""
    
    @Published var avatarImage: UIImage?
    @Published var selectedAvatar: PhotosPickerItem? = nil
    
    @Published var backgroundImage: UIImage? = nil
    @Published var selectedBackground: PhotosPickerItem? = nil
    
    @Published var latitudeText: String = ""
    @Published var longitudeText: String = ""
    
    @Published var isSubmitting: Bool = false
    
    @Published var isPublic: Bool = true
    
    func createCommunity() async {
        
        guard validateInputs() else { return }
        
        isSubmitting = true
        
        do {
            let communityData = try prepareCommunityData()
            try await CommunityManager.shared.createCommunity(from: communityData)
            print("Community created successfully!")
        } catch {
            print("Failed to create community: \(error.localizedDescription)")
        }
      
    }
    
    private func prepareCommunityData() throws -> CommunityForCreationDTO {
        
        guard let latitude = Double(latitudeText.replacingOccurrences(of: ",", with: ".")),
              let longitude = Double(longitudeText.replacingOccurrences(of: ",", with: ".")),
              
              let avatarImage = avatarImage,
              let avatarData = avatarImage.jpegData(compressionQuality: 0.8),
              
              let backgroundImage = backgroundImage,
              let backgroundData = backgroundImage.jpegData(compressionQuality: 0.8)
        else {
            throw NSError(domain: "InvalidInput", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid input data"])
        }
        
        let avatarFileData = FileDataForCreationDto(
            data: avatarData.base64EncodedString(),
            description: "Avatar Image",
            type: 0
        )
        
        let backgroundFileData = FileDataForCreationDto(
            data: backgroundData.base64EncodedString(),
            description: "Background Image",
            type: 0
        )
        
        return CommunityForCreationDTO(
            name: name,
            description: description,
            avatar: avatarFileData,
            Background: backgroundFileData,
            latitude: latitude,
            longitude: longitude,
            isPublic: isPublic
        )
    }
    
    
    func validateInputs() -> Bool {
        guard !name.isEmpty,
              !description.isEmpty,
              avatarImage != nil,
              backgroundImage != nil,
              validCoordinates(latitude: latitudeText, longitude: longitudeText)
        else {
            return false
        }
        return true
    }
    
    func loadSelectedPhoto(from item: PhotosPickerItem?) async -> UIImage? {
        
        guard let item else { return nil }
        
        if let data = try? await item.loadTransferable(type: Data.self),
           let uiImage = UIImage(data: data) {
            return uiImage
        }
        return nil
    }
    
    private func validCoordinates(latitude: String, longitude: String) -> Bool {
        
        // changing string to double
        guard let latitude = Double(latitudeText.replacingOccurrences(of: ",", with: ".")),
              let longitude = Double(longitudeText.replacingOccurrences(of: ",", with: ".")) else {
            return false
        }
        
        let isLatitudeValid = latitude >= -90 && latitude <= 90
        let isLongitudeValid = longitude >= -180 && longitude <= 180
        
        return isLatitudeValid && isLongitudeValid
    }
}
