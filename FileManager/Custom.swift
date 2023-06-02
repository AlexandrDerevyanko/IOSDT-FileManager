//
//  Custom.swift
//  FileManager
//
//  Created by Aleksandr Derevyanko on 23.03.2023.
//

import UIKit
import KeychainSwift

final class CustomButton: UIButton {
    typealias Action = () -> Void
    
    var buttonAction: Action
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
    
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


