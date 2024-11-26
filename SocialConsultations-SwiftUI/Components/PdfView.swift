//
//  PdfView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 26/11/2024.
//

import SwiftUI
import PDFKit

struct PDFViewRepresentable: UIViewRepresentable {
    let pdfData: Data
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.document = PDFDocument(data: pdfData)
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        
    }
}


struct PdfView: View {
    
    let base64String: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            if let pdfData = Data(base64Encoded: base64String) {
                PDFViewRepresentable(pdfData: pdfData)
                    .edgesIgnoringSafeArea(.all)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            ShareLink(item: pdfData.toTempFileURL(fileName: "document.pdf")!) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.title3)
                            }
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Back") {
                                dismiss()
                            }
                        }
                    }
            } else {
                Text("Failed to load file")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Back") {
                                dismiss()
                            }
                        }
                    }
            }
        }
        
    }
}

#Preview {
    PdfView(base64String: Base64examples.pdf2_base64)
}


extension Data {
    // Saves temporalily data to temporary file & returns URL to that file
    func toTempFileURL(fileName: String) -> URL? {
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        do {
            try self.write(to: tempURL)
            return tempURL
        } catch {
            print("Failed to write data to temp file: \(error)")
            return nil
        }
    }
}
