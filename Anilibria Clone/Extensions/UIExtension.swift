//
//  UIExtension.swift
//  AnilibriaClone
//
//  Created by Мурад on 6/4/25.
//

import SwiftUI
import UIKit


extension CGFloat {
    
    static var screenWidth: Double {
        return UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: Double {
        return UIScreen.main.bounds.size.height
    }
    
    static var topInsets: Double {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                return 0.0
            }
            return Double(window.safeAreaInsets.top)
    }
    
    static var bottomInsets: Double {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                return 0.0
            }
        return Double(window.safeAreaInsets.bottom)
    }
    
    static var horizontalInsets: Double {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                return 0.0
            }
        return Double(window.safeAreaInsets.left + window.safeAreaInsets.right)
    }
    
    static var verticalInsets: Double {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                return 0.0
            }
            return Double(window.safeAreaInsets.top + window.safeAreaInsets.bottom)
    }
}

extension Date {
    var weekDay: Int {
        let calendar = Calendar(identifier: .iso8601)
        let weekday = calendar.component(.weekday, from: self)
        // Преобразуем: 2 (понедельник) -> 1, 3 -> 2, ..., 1 (воскресенье) -> 7
        return weekday == 1 ? 7 : weekday - 1
    }
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1 && presentedViewController == nil
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

extension Int {
    func formatSeconds() -> String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension View {
    func primaryPlaybackButtonStyle() -> some View {
        modifier(PrimaryPlayBackButtonStyle())
    }
    
    func secondaryPlaybackButtonStyle() -> some View {
        modifier(SecondaryPlayBackButtonStyle())
    }
    
    func modifyOrientation(_ mask: UIInterfaceOrientationMask) {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            AppDelegate.orientation = mask
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: mask))
            
            windowScene.keyWindow?.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
        }
    }
}
