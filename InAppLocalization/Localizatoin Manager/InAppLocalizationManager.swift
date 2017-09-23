//
//  InAppLocalizationManager.swift
//  InAppLocalization
//
//  Created by Daniel Tsai on 2017/9/23.
//  Copyright © 2017年 Daniel T. All rights reserved.
//

import Foundation

enum LanguageCode: String {
    case en
    case zh
    case ja
}

class InAppLocalizationManager {
    
    static var shared: InAppLocalizationManager {
        return mInstance
    }
    private static let mInstance = InAppLocalizationManager()
    private let localizationDictionary: [String: String]
    private(set) var languageCode = LanguageCode.en
    
    init() {
        let fileUrl = Bundle.main.url(forResource: "LocalizedStrings", withExtension: "plist")
        let data = try? Data(contentsOf: fileUrl!)
        localizationDictionary = try! PropertyListSerialization.propertyList(from: data!, options: [], format: nil) as! [String: String]
        reloadLanguageCode()
    }
    
    // MARK: - Public functions

    /// Get the string in the localization dictionary by the key.
    ///
    /// - Parameter key: The localization key
    /// - Returns: The string if there is one string coresponding to the key in the dictionary, otherwise returns `nil`.
    func localizedString(_ key: String) -> String? {
        let localizeKey = key + "." + languageCode.rawValue
        return localizationDictionary[localizeKey]
    }
    
    /// Reload the language code from the language preference in user defaults, or from the system locale if there's no language preference in user defaults.
    func reloadLanguageCode() {
        if let code = UserDefaults.standard.string(forKey: "inApplanguageCode") {
            languageCode = LanguageCode.init(rawValue: code)!
        } else if let code = Locale.current.languageCode {
            languageCode = LanguageCode.init(rawValue: code) ?? .en // The user's device language setting may not be in the enum `LanguageCode`
        }
    }
    
}
