
import UIKit

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
        
        let alertCancel = UIAlertAction(title: "Отмена", style: .cancel)
        
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
