
import UIKit

class AlertPicker {
    static let defaultPicker = AlertPicker()
    
    func showErrors(showIn viewController: UIViewController, error: Errors) {
        let alertController = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        
        let alertOK = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(alertOK)
        viewController.present(alertController, animated: true)
    }
}
