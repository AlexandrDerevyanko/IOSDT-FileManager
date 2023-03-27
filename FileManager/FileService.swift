//
//  FileService.swift
//  FileManager
//
//  Created by Aleksandr Derevyanko on 24.03.2023.
//

import Foundation

class FileService {
    static let defaulFileService = FileService()
    
    var path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    var documents: [String] {
        do {
            return try FileManager.default.contentsOfDirectory(atPath: path)
        } catch {
            print(error)
        }
        return []
    }
}
