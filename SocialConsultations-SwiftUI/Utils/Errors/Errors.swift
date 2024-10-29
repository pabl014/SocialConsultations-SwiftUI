//
//  Errors.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/10/2024.
//

import Foundation

enum AuthenticationError: Error, LocalizedError {
    case invalidCredentials(String)
    case failedToEncodeRequestBody
    case failedToDecodeResponse
    case serverError(String)

    var errorDescription: String? {
        switch self {
        case .invalidCredentials(let message):
            return message
        case .failedToEncodeRequestBody:
            return "Failed to encode request body."
        case .failedToDecodeResponse:
            return "Failed to decode server response."
        case .serverError(let message):
            return message
        }
    }
}
