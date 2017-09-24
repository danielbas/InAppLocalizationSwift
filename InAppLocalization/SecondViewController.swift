//
//  SecondViewController.swift
//  InAppLocalization
//
//  Created by Daniel Tsai on 2017/9/23.
//  Copyright © 2017年 Daniel T. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var pageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: Notification.Name.init(rawValue: "LanguageDidChanged"), object: nil, queue: nil) { [weak self] notification in
            self?.reloadStrings()
        }
        reloadStrings()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func reloadStrings() {
        DispatchQueue.main.async {
            self.pageLabel.text = "Second View Controller".localized(key: "second.vc.title")
        }
    }
    
}

