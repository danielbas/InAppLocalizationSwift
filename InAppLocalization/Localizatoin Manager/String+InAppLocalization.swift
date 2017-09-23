//
//  String+InAppLocalization.swift
//  InAppLocalization
//
//  Created by Daniel Tsai on 2017/9/23.
//  Copyright © 2017年 Daniel T. All rights reserved.
//

import Foundation

extension String {
    
    /// Get the localized string using the key.
    ///
    /// - Parameter key: The localization key.
    /// - Returns: The localized string if there exists the value of the key. Otherwise, return the string itself.
    func localized(key: String) -> String {
        if let localizedString = InAppLocalizationManager.shared.localizedString(key) {
            return localizedString
        }
        return self
    }

}
