//
//  Custom.swift
//  FileManager
//
//  Created by Aleksandr Derevyanko on 23.03.2023.
//

import UIKit

class Picker {
    static let defaultPicker = Picker()
    
    func getImage(showPickerIn viewController: UIViewController, title: String, message: String, imageData: Data?, completion: ((_ text1: String, _ imageData: Data) -> ())?) {
        let alertController =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField()
        
        let alertOK = UIAlertAction(title: "Ok", style: .default) { alert in
            if let text = alertController.textFields?[0].text, text != "",
            let imageData = imageData {
                completion?(text, imageData)
            }
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(alertOK)
        alertController.addAction(alertCancel)
        viewController.present(alertController, animated: true)
    }
}
