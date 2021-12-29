//
//  ContentView.swift
//  Softbox
//
//  Created by Emilio Schepis on 29/12/21.
//

import SwiftUI
import AppKit

struct ContentView: View {
    @EnvironmentObject private var manager: SoftboxManager
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Rectangle()
                .foregroundColor(manager.color)
            ColorPicker("Softbox Color", selection: $manager.color)
                .padding()
                .background(Color(NSColor.textBackgroundColor).opacity(0.5))
                .cornerRadius(8.0)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
