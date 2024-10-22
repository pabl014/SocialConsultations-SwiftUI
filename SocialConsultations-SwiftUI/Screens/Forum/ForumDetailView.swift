//
//  ForumDetailView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 15/10/2024.
//

import SwiftUI

struct ForumDetailView: View {
    
    @State private var isShowingAddPostSheet: Bool = false
    @State private var respondText: String = "Write your response..."
    
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                header
                
                Divider()
                
                Text("Responds")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, -4)
                
                LazyVStack {
                    ForEach(0..<20) { _ in
                        PostCell()
                    }
                }
                
            }
            
            // Floating button
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        isShowingAddPostSheet.toggle()
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
                    .sheet(isPresented: $isShowingAddPostSheet) {
                        NewRespondSheet(newRespondText: $respondText)
                    }
                }
            }
        }
    }
    
    var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            
            HStack(spacing: 8) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("Pep Guardiola")
                        .font(.headline)
                    
                    Text("6 hours ago")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            
            VStack {
                Text("Society of Bialystok residents")
                    .bold()
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            
            
            VStack(alignment: .leading) {
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                    .font(.body)
                    .foregroundColor(.primary)
                    .foregroundStyle(Color(hex: "#000080"))
                    
            }
            .padding(.horizontal)
            
            
            HStack(spacing: 20) {
                Text("67 responds")
                Text("6985 can participate")
            }
            .padding()
        }
        .background(GradientTest())
        //.background(Color(UIColor.secondarySystemBackground))
        .itemCornerRadius(20)
        .shadow(radius: 5)
        .padding()
    }
}

struct NewRespondSheet: View {
    
    @Binding var newRespondText: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $newRespondText)
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
                    self.newRespondText = "Add respond text..."
                }
            )
        }
    }
}

#Preview {
    ForumDetailView()
}
