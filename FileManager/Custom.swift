//
//  Custom.swift
//  FileManager
//
//  Created by Aleksandr Derevyanko on 23.03.2023.
//

import UIKit
import KeychainSwift

class Picker {
    static let defaultPicker = Picker()
    
    func getFolder(showPickerIn viewController: UIViewController, title: String, message: String, completion: ((_ text: String?, _ errors: Errors?) -> ())?) {
        let alertController =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField()
        
        let alertOK = UIAlertAction(title: "Ok", style: .default) { alert in
            if let text = alertController.textFields?[0].text, text != "" {
                completion?(text, nil)
            } else {
                completion?(nil, .nameIsEmpty)
            }
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(alertOK)
        alertController.addAction(alertCancel)
        viewController.present(alertController, animated: true)
    }
    
    func getImage(showPickerIn viewController: UIViewController, title: String, message: String, imageData: Data?, completion: ((_ text1: String?, _ imageData: Data?, _ errors: Errors?) -> ())?) {
        let alertController =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField()
        
        let alertOK = UIAlertAction(title: "Ok", style: .default) { alert in
            if let text = alertController.textFields?[0].text, text != "" {
                if let imageData = imageData {
                    completion?(text, imageData, nil)
                } else {
                    completion?(nil, nil, .unexpected)
                }
            } else {
                completion?(nil, nil, .nameIsEmpty)
            }
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(alertOK)
        alertController.addAction(alertCancel)
        viewController.present(alertController, animated: true)
    }
    
    func errorsAlert(showIn viewController: UIViewController, error: Errors) {
        let alertController = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        
        let alertOK = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(alertOK)
        viewController.present(alertController, animated: true)
    }
}

class Alert {
    static let defaultAlert = Alert()
    
    func errors(showIn viewController: UIViewController, error: Errors) {
        let alertController = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        
        let alertOK = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(alertOK)
        viewController.present(alertController, animated: true)
    }
}

final class CustomButton: UIButton {
    typealias Action = () -> Void
    
    var buttonAction: Action
    
    init(title: String, titleColor: UIColor = .black, bgColor: UIColor, hidden: Bool = false, action: @escaping Action) {
        buttonAction = action
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = bgColor
        isHidden = hidden
        layer.cornerRadius = 12
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func buttonTapped() {
        buttonAction()
    }
}

class Autorization {
    static let defaultAutorization = Autorization()
    
    func addPassword(password: String) {
        KeychainSwift().set(password, forKey: "Password")
    }
    
    func checkPassword(passwordToCheck: String) -> Bool {
        let password: String? = KeychainSwift().get("Password")
        if password == passwordToCheck {
            return true
        } else {
            return false
        }
    }
}
