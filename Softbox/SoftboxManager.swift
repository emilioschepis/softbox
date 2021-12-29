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
}

class SoftboxManager: NSObject, ObservableObject {
    @Published var color: Color
    
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
        
        super.init()
        
        $color
            .debounce(for: .seconds(1.0), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] in self?.saveLatestColor(color: $0) }
            .store(in: &cancellables)
    }
    
    private func saveLatestColor(color: Color) {
        guard let colorData = try? encoder.encode(color) else { return }
        defaults.set(colorData, forKey: DefaultsKeys.color)
    }
}
