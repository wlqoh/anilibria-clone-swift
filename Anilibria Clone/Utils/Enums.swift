//
//  Enums.swift
//  AnilibriaClone
//
//  Created by Мурад on 7/4/25.
//

import Foundation
import SwiftUI

enum StandardListStatus {
    case initial
    case loading
    case loaded
    case error
}

enum PlayerOrientation: String, CaseIterable {
    case portrait = "Portrait"
    case landscapeRight = "LandscapeRight"
    case landscapeLeft = "LandscapeLeft"
    case system = "System"
    
    var mask: UIInterfaceOrientationMask {
            switch self {
            case .portrait: return .portrait
            case .landscapeRight: return .landscapeRight
            case .landscapeLeft: return .landscapeLeft
            case .system: return .allButUpsideDown
            }
        }
}
