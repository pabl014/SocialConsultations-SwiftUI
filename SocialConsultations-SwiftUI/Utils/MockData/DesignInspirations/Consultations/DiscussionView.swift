//
//  DiscussionView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 25/10/2024.
//

import SwiftUI

struct DiscussionView: View {
    
    @State private var isShowingAddCommentSheet: Bool = false
    @State private var newCommentText: String = "Add comment..."
    
    var body: some View {
        
        ZStack {
            List {
                PostCell()
                PostCell()
                PostCell()
                PostCell()
                PostCell()
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        isShowingAddCommentSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 25))
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .padding()
                    .sheet(isPresented: $isShowingAddCommentSheet) {
                        NewRespondSheet(newRespondText: $newCommentText)
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    DiscussionView()
}


struct AddCommentSheet: View {
    
    @Binding var newCommentText: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $newCommentText)
                    .frame(height: 250)
                    .padding()
                    //.background(Color(hex: "#F2F2F2"))
                    .itemCornerRadius(20)
                
                Spacer()
            }
            .navigationBarTitle("New respond", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Upload") {
                    dismiss()
                    self.newCommentText = "Add respond text..."
                }
            )
        }
    }
}
