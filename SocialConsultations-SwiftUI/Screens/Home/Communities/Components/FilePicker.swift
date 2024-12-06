//
//  FilePicker.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 29/11/2024.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct FilePicker: UIViewControllerRepresentable {
    
    var didPickFiles: ([URL]) -> Void

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf])
        picker.allowsMultipleSelection = true
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(didPickFiles: didPickFiles)
    }
}


// File Selection handler
class Coordinator: NSObject, UIDocumentPickerDelegate {
    
    var didPickFiles: ([URL]) -> Void

    init(didPickFiles: @escaping ([URL]) -> Void) {
        self.didPickFiles = didPickFiles
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        didPickFiles(urls)
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        didPickFiles([])
    }
}
