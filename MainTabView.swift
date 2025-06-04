//
//  MainTabView.swift
//  Math2TikZ
//
//  Created by Elliott on 1/6/2025.
//


import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Editor", systemImage: "pencil")
                }

            TikzChartGalleryView()
                .tabItem {
                    Label("Gallery", systemImage: "photo.on.rectangle")
                }
        }
    }
}


