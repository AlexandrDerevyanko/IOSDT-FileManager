//
//  Errors.swift
//  FileManager
//
//  Created by Aleksandr Derevyanko on 24.03.2023.
//

import Foundation

enum Errors: Error {
    case invalidPassword
    case weakPassword
    case mismatchPassword
    case nameExist
    case nameIsEmpty
    case unexpected
}

extension Errors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidPassword:
            return NSLocalizedString("Неверный пароль",
                                     comment: "")
        case .weakPassword:
            return NSLocalizedString("Пароль состоит менее чем из 4 символов",
                                     comment: "")
        case .mismatchPassword:
            return NSLocalizedString("Введенные пароли не совпадают, введите пароль заново",
                                     comment: "")
        case .nameExist:
            return NSLocalizedString("Введенное имя уже существует",
                                     comment: "")
        case .nameIsEmpty:
            return NSLocalizedString("Поле не заполнено",
                                     comment: "")
        case .unexpected:
            return NSLocalizedString("Что то пошло не так",
                                     comment: "")
        }
    }
}
