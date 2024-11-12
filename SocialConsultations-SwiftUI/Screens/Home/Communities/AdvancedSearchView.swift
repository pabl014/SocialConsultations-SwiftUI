//
//  AdvancedSearchView.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 10/11/2024.
//

import SwiftUI

struct AdvancedSearchView: View {
    
    @State private var searchQuery: String = ""
    @State private var name: String = ""
    @State private var issue: String = ""
    @State private var isPrivate: Bool = false
    @State private var selectedOrderType: String = "none"
    
    @State private var showResultsSheet = false
    
    var body: some View {
        
        VStack {
            Form {
                
                Section(header: Text("Search")) {
                    TextField("Search...", text: $searchQuery)
                }
                
                Section(header: Text("Advanced")) {
                    TextField("Issue name", text: $issue)
                    Toggle("Is private", isOn: $isPrivate)
                    
                    Picker("Order", selection: $selectedOrderType) {
                        Text("None").tag("none")
                        Text("Ascending").tag("asc")
                        Text("Descending").tag("desc")
                    }
                }
                
                Button {
                    showResultsSheet.toggle()
                } label: {
                    Text("Search")
                        .defaultButtonStyle()
                        .padding(.horizontal, -20)
                }
            }
        }
        .navigationTitle("Advanced search")
        .sheet(isPresented: $showResultsSheet) {
            SearchResultsView(showResultsSheet: $showResultsSheet) // Arkusz z wynikami wyszukiwania
        }
    }
}

struct SearchResultsView: View {
    
    @Binding var showResultsSheet: Bool
    // Przykładowe dane - tutaj możesz pobrać lub przekazać listę wyników
    let communities = ["Community 1", "Community 2", "Community 3", "Community 4"]
    
    
    var body: some View {
        NavigationStack {
            List(communities, id: \.self) { community in
                NavigationLink {
                    ConsultationsView()
                } label: {
                    Text(community)
                }
            }
            .navigationTitle("Search Results")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                    }
                }
            }
        }
    }
}


#Preview {
    NavigationStack {
        AdvancedSearchView()
    }
}
