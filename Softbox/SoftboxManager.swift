//
//  SoftboxManager.swift
//  Softbox
//
//  Created by Emilio Schepis on 29/12/21.
//

import Combine
import Foundation
import SwiftUI

enum DefaultsKeys {
    static let color = "KEY_COLOR"
    static let favorites = "KEY_FAVORITES"
}

class SoftboxManager: NSObject, ObservableObject {
    @Published var color: Color
    @Published var favorites: [Color]
    
    private let defaults: UserDefaults
    private let encoder = JSONEncoder()
    private var cancellables = Set<AnyCancellable>()
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        
        if let colorData = defaults.data(forKey: DefaultsKeys.color),
           let color = try? JSONDecoder().decode(Color.self, from: colorData) {
            self.color = color
        } else {
            self.color = .gray
        }
        
        if let favoritesData = defaults.data(forKey: DefaultsKeys.favorites),
           let favorites = try? JSONDecoder().decode([Color].self, from: favoritesData) {
            self.favorites = favorites
        } else {
            self.favorites = [.red, .green, .blue]
        }
        
        super.init()
        
        $color
            .debounce(for: .seconds(1.0), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] in self?.saveLatestColor(color: $0) }
            .store(in: &cancellables)
    }
    
    func addToFavorites() {
        if let index = favorites.firstIndex(of: color) {
            favorites.swapAt(0, index)
        } else {
            favorites.insert(color, at: 0)
        }
        
        saveFavorites()
    }
    
    func removeFromFavorites(_ color: Color) {
        favorites.removeAll(where: { $0 == color })
        saveFavorites()
    }
    
    private func saveLatestColor(color: Color) {
        guard let colorData = try? encoder.encode(color) else { return }
        defaults.set(colorData, forKey: DefaultsKeys.color)
    }
    
    private func saveFavorites() {
        guard let favoritesData = try? encoder.encode(favorites) else { return }
        defaults.set(favoritesData, forKey: DefaultsKeys.favorites)
    }
}
