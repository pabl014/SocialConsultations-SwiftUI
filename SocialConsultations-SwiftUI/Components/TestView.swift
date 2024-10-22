//
//  TestView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 13/10/2024.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Górny pasek nawigacyjny
                HStack {
                    Menu {
                        Button("Newest") { }
                        Button("Featured") { }
                        Button("Frequent") { }
                    } label: {
                        HStack {
                            Text("Topics")
                            Image(systemName: "chevron.down")
                        }
                    }
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .padding(.trailing, 10)
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                
                // Pasek zakładek
                HStack {
                    Button(action: {}) {
                        Text("Newest")
                    }
                    Spacer()
                    Button(action: {}) {
                        Text("Featured")
                            .bold()
                    }
                    Spacer()
                    Button(action: {}) {
                        Text("Frequent")
                    }
                    Spacer()
                    Button(action: {}) {
                        Text("Most Recent")
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                // Lista postów
                List {
                    ForEach(0..<10) { _ in
                        PostView()
                    }
                }
                .listStyle(PlainListStyle())
                
                // Przycisk dodawania
                HStack {
                    Spacer()
                    Button(action: {
                        // Akcja dla dodania posta
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.pink)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding()
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}
struct PostView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading) {
                    Text("Brice Séraphin")
                        .font(.headline)
                    Text("6 hours ago")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: "heart")
                    .foregroundColor(.pink)
            }
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae erat eu nisi molestie!")
                .lineLimit(3)
            
            HStack {
                Text("568 votes")
                Text("347 answers")
                Text("2,515 views")
                Spacer()
                Button(action: {
                    // Akcja dla dodania
                }) {
                    Text("ADD")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            .font(.subheadline)
            .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct Test2View: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                // Górny pasek nawigacyjny
                HStack {
                    Text("Forum")
                        .font(.title)
                        .bold()
                    Spacer()
                    Image(systemName: "magnifyingglass")
                    Image(systemName: "bell")
                }
                .padding()
                
                // Pasek zakładek
                HStack(spacing: 20) {
                    Button(action: {
                        selectedTab = 0
                    }) {
                        Text("Featured Topics")
                            .bold()
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(selectedTab == 0 ? Color.black.opacity(0.1) : Color.clear)
                            .cornerRadius(15)
                    }
                    
                    Button(action: {
                        selectedTab = 1
                    }) {
                        Text("Most Recent")
                            .bold()
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(selectedTab == 1 ? Color.black.opacity(0.1) : Color.clear)
                            .cornerRadius(15)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Divider()
                
                // Lista postów
                List {
                    ForEach(0..<5) { _ in
                        CompactPostView()
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}
struct CompactPostView: View {
    var body: some View {
        HStack {
            // Avatar
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading, spacing: 5) {
                // Tytuł i autor
                Text("Lorem ipsum dolor")
                    .font(.headline)
                    .lineLimit(1)
                Text("Brice Séraphin")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            VStack(alignment: .trailing, spacing: 5) {
                // Reakcje i data
                Text("08 JUN 2018")
                    .font(.caption)
                    .foregroundColor(.gray)
                Image(systemName: "heart.fill")
                    .foregroundColor(.pink)
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    TestView()
}
