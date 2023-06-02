
import KeychainSwift

class Authorization {
    static let defaultAutorization = Authorization()
    
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
