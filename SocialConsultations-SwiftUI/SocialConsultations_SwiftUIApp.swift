//
//  SocialConsultations_SwiftUIApp.swift
//  SocialConsultations-SwiftUI
//
//  Created by Paweł Rudnik on 08/10/2024.
//

import SwiftUI

@main
struct SocialConsultations_SwiftUIApp: App {
    
    init() {
        UIView.appearance().overrideUserInterfaceStyle = .light
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
