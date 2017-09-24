//
//  FirstViewController.swift
//  InAppLocalization
//
//  Created by Daniel Tsai on 2017/9/23.
//  Copyright © 2017年 Daniel T. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var languageControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: Notification.Name.init(rawValue: "LanguageDidChanged"), object: nil, queue: nil) { [weak self] notification in
            self?.reloadStrings()
        }
        // Set and initialize the appearance of the segment control
        languageControl.addTarget(self, action: #selector(controlValueChanged(_:)), for: .valueChanged)
        switch InAppLocalizationManager.shared.languageCode {
        case .en:
            languageControl.selectedSegmentIndex = 0
        case .zh:
            languageControl.selectedSegmentIndex = 1
        case .ja:
            languageControl.selectedSegmentIndex = 2
        }
        reloadStrings()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func reloadStrings() {
        DispatchQueue.main.async {
            self.pageLabel.text = "Select app language".localized(key: "first.vc.title")
        }
    }
    
    @objc func controlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(LanguageCode.en.rawValue, forKey: "inApplanguageCode")
        case 1:
            UserDefaults.standard.set(LanguageCode.zh.rawValue, forKey: "inApplanguageCode")
        case 2:
            UserDefaults.standard.set(LanguageCode.ja.rawValue, forKey: "inApplanguageCode")
        default:
            UserDefaults.standard.set(LanguageCode.en.rawValue, forKey: "inApplanguageCode")
        }
        InAppLocalizationManager.shared.reloadLanguageCode()
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "LanguageDidChanged"), object: self)
    }
    
}
