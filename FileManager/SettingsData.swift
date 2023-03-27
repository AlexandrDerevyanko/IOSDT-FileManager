//
//  SettingsData.swift
//  FileManager
//
//  Created by Aleksandr Derevyanko on 27.03.2023.
//

import Foundation
import UIKit

class SettingsData {
    static let defaultSettingsData = SettingsData(title: "")
    
    var title: String
    var value: String?
    var isBool: Bool?
    var action: (() -> Void)?
    
    init(title: String, value: String? = nil, isBool: Bool? = nil, action: (() -> Void)? = nil) {
        self.title = title
        self.value = value
        self.isBool = isBool
        self.action = action
    }
    
    func changePassword(showIn viewController: UIViewController?) {
        let VC = LogInViewController()
        VC.isResizeble = false
        VC.firstState()
        viewController?.present(VC, animated: true)
    }
}

var boolSettingsArray: [SettingsData] = [
    SettingsData(title: "Сортировка файлов в алфавитном порядке", value: "aZSort")
]

var settingsArray: [SettingsData] = [
    SettingsData(title: "Сменить пароль")
]
