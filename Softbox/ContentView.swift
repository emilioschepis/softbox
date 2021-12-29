//
//  ContentView.swift
//  Softbox
//
//  Created by Emilio Schepis on 29/12/21.
//

import SwiftUI
import AppKit

struct ContentView: View {
    @State private var color = Color.accentColor
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Rectangle()
                .foregroundColor(color)
            ColorPicker("Softbox Color", selection: $color)
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
