//
//  LogInViewController.swift
//  FileManager
//
//  Created by Aleksandr Derevyanko on 24.03.2023.
//

import UIKit
import KeychainSwift
import SnapKit

class LogInViewController: UIViewController {
    
    var isResizeble = true
    
    private var password: String?
    
    let textField: UITextField = {
        let texField = UITextField()
        texField.backgroundColor = .white
        texField.layer.cornerRadius = 15
        texField.text = "123456"
        texField.translatesAutoresizingMaskIntoConstraints = false
        return texField
    }()
    
    private lazy var createPasswordButton = CustomButton(title: "Создать пароль", bgColor: .cyan) {
        self.createPasswordButtonPressed()
    }
    
    private lazy var enterPasswordButton = CustomButton(title: "Введите пароль", bgColor: .cyan) {
        self.enterPasswordButtonPressed()
    }
    
    private lazy var repeatPasswordButton = CustomButton(title: "Повторите пароль", bgColor: .cyan) {
        self.repeatPasswordButtonPressed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarController?.tabBar.isHidden = true
        if isResizeble {
            checkPassword()
            self.isResizeble = false
        }
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(textField)
        view.addSubview(createPasswordButton)
        view.addSubview(enterPasswordButton)
        view.addSubview(repeatPasswordButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(view).offset(-16)
            make.height.equalTo(40)
        }
        
        createPasswordButton.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.right.equalTo(view).offset(-16)
            make.height.equalTo(40)
        }
        
        enterPasswordButton.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.right.equalTo(view).offset(-16)
            make.height.equalTo(40)
        }
        
        repeatPasswordButton.snp.makeConstraints { make in
            make.left.equalTo(view).offset(16)
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.right.equalTo(view).offset(-16)
            make.height.equalTo(40)
        }
    }
    
    func firstState() {
        createPasswordButton.isHidden = false
        enterPasswordButton.isHidden = true
        repeatPasswordButton.isHidden = true
    }
    
    private func secondState() {
        createPasswordButton.isHidden = true
        enterPasswordButton.isHidden = false
        repeatPasswordButton.isHidden = true
    }
    
    private func checkPassword() {
        let allKeys = KeychainSwift().allKeys
        if allKeys.isEmpty {
            firstState()
        } else {
            secondState()
        }
    }
    
    private func createPasswordButtonPressed() {
        if let text = self.textField.text, text != "" {
            if text.count < 4 {
                Alert.defaultAlert.errors(showIn: self, error: .weakPassword)
            } else {
                self.password = text
                self.textField.text = ""
                self.createPasswordButton.isHidden = true
                self.repeatPasswordButton.isHidden = false
            }
        } else {
            Alert.defaultAlert.errors(showIn: self, error: .nameIsEmpty)
        }
    }
    
    private func enterPasswordButtonPressed() {
        let password = self.textField.text
        if Autorization.defaultAutorization.checkPassword(passwordToCheck: password ?? "") {
            let VC = FilesViewController()
            navigationController?.tabBarController?.tabBar.isHidden = false
            navigationController?.pushViewController(VC, animated: true)
        } else {
            Alert.defaultAlert.errors(showIn: self, error: .invalidPassword)
        }
    }
    
    private func repeatPasswordButtonPressed() {
        if let text = self.textField.text, text == self.password {
            Autorization.defaultAutorization.addPassword(password: self.password!)
            let VC = FilesViewController()
            navigationController?.tabBarController?.tabBar.isHidden = false
            navigationController?.pushViewController(VC, animated: true)
            self.dismiss(animated: true)
        } else {
            Alert.defaultAlert.errors(showIn: self, error: .mismatchPassword)
            firstState()
        }
    }
    
}
