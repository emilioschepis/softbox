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
            VStack(alignment: .trailing) {
                ColorPicker("Softbox Color", selection: $manager.color)
                    .padding(.bottom, 4.0)
                HStack(alignment: .top) {
                    Button(action: { manager.addToFavorites() }) {
                        ZStack {
                            Circle()
                                .frame(width: 32.0, height: 32.0, alignment: .center)
                                .foregroundColor(Color(NSColor.textBackgroundColor))
                            Image(systemName: "plus")
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    ForEach(manager.favorites, id: \.description) { favorite in
                        VStack {
                            Button(action: { manager.color = favorite }) {
                                Circle()
                                    .frame(width: 32.0, height: 32.0, alignment: .center)
                                    .foregroundColor(favorite)
                            }
                            .buttonStyle(PlainButtonStyle())
                            Button(action: { manager.removeFromFavorites(favorite) }) {
                                ZStack {
                                    Circle()
                                        .frame(width: 24.0, height: 24.0, alignment: .center)
                                        .foregroundColor(Color(NSColor.textBackgroundColor))
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
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
