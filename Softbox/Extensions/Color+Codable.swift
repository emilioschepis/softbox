//
//  Color+Codable.swift
//  Softbox
//
//  Created by Emilio Schepis on 29/12/21.
//

import SwiftUI

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case red, green, blue, alpha
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let red = try container.decode(Double.self, forKey: .red)
        let green = try container.decode(Double.self, forKey: .green)
        let blue = try container.decode(Double.self, forKey: .blue)
        let alpha = try container.decode(Double.self, forKey: .alpha)
        
        self.init(NSColor(deviceRed: red, green: green, blue: blue, alpha: alpha))
    }
    
    public func encode(to encoder: Encoder) throws {
        guard let components = NSColor(self).cgColor.components else {
            return
        }
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(components[0], forKey: .red)
        try container.encode(components[1], forKey: .green)
        try container.encode(components[2], forKey: .blue)
        try container.encode(components[3], forKey: .alpha)
    }
}
