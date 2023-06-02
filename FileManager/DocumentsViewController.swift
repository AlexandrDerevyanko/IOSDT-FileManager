//
//  ViewController.swift
//  FileManager
//
//  Created by Aleksandr Derevyanko on 17.03.2023.
//

import UIKit
import SnapKit

class DocumentsViewController: UIViewController {
    
    let fileService = FileService.defaulFileService
    
    lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        return picker
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(FilesTableViewCell.self, forCellReuseIdentifier: "EventCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: FirstSectionSettingsTableViewCell.notificationName, object: nil)
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        setupConstraints()
        setupButtons()
        navigationItem.title = NSString(string: fileService.path).lastPathComponent
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints({ make in
            make.edges.equalTo(view)
        })
    }
    
    func setupButtons() {
        let addPhotoButton = UIBarButtonItem(title: "Добавить фото", style: .plain, target: self, action: #selector(addPhotoButtonPressed))
        navigationItem.rightBarButtonItem = addPhotoButton
        let addFolderButton = UIBarButtonItem(title: "Добавить папку", style: .plain, target: self, action: #selector(addFolderButtonPressed))
        navigationItem.rightBarButtonItems = [addPhotoButton, addFolderButton]
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @objc
    private func addPhotoButtonPressed() {
        present(picker, animated: true)
    }
    @objc
    private func addFolderButtonPressed() {
        Picker.defaultPicker.getFolder(showPickerIn: self, title: "Создание папки", message: "Введите имя папки") { text, errors  in
            if let errors = errors {
                Picker.defaultPicker.errorsAlert(showIn: self, error: errors)
            } else {
                let folderPath = self.fileService.path + "/" + text!
                let isFolder = FileManager.default.fileExists(atPath: folderPath)
                if isFolder {
                    Picker.defaultPicker.errorsAlert(showIn: self, error: .nameExist)
                } else {
                    do { try FileManager.default.createDirectory(at: URL(filePath: folderPath), withIntermediateDirectories: true)
                    } catch {
                        print(error)
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    @objc
    private func reloadData() {
        tableView.reloadData()
    }
        
}

extension DocumentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileService.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? FilesTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        let data = fileService.path + "/" + fileService.documents[indexPath.row]
        if UserDefaults.standard.bool(forKey: "aZSort") {
            let documents = fileService.documents
            let sortedDocuments = documents.sorted(by: <)
            var viewModel = FilesTableViewCell.ViewModel(title: sortedDocuments[indexPath.row], description: "-")
            var objcBool: ObjCBool = false
            FileManager.default.fileExists(atPath: fileService.path + "/" + fileService.documents[indexPath.row], isDirectory: &objcBool)
            if objcBool.boolValue {
                viewModel.description = "Папка"
                cell.accessoryType = .disclosureIndicator
            } else {
                viewModel.description = "Файл"
                viewModel.image = UIImage(contentsOfFile: data) ?? UIImage()
                cell.accessoryType = .none
            }
            cell.setup(viewModel)
            return cell
        } else {
            var viewModel = FilesTableViewCell.ViewModel(title: fileService.documents[indexPath.row], description: "-")
            var objcBool: ObjCBool = false
            FileManager.default.fileExists(atPath: fileService.path + "/" + fileService.documents[indexPath.row], isDirectory: &objcBool)
            if objcBool.boolValue {
                viewModel.description = "Папка"
                cell.accessoryType = .disclosureIndicator
            } else {
                viewModel.description = "Файл"
                viewModel.image = UIImage(contentsOfFile: data) ?? UIImage()
                cell.accessoryType = .none
            }
            cell.setup(viewModel)

            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPath = fileService.path + "/" + fileService.documents[indexPath.row]
        
        var objcBool: ObjCBool = false
        FileManager.default.fileExists(atPath: fileService.path + "/" + fileService.documents[indexPath.row], isDirectory: &objcBool)
        if objcBool.boolValue {
            let newVC = DocumentsViewController()
            newVC.fileService.path = selectedPath
            navigationController?.pushViewController(newVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pathToItem = fileService.path + "/" + fileService.documents[indexPath.row]
            do {
                try FileManager.default.removeItem(atPath: pathToItem)
            } catch {
                print(error)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
}

extension DocumentsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageData = image.pngData()
        self.dismiss(animated: true)
        Picker.defaultPicker.getImage(showPickerIn: self, title: "Введите название фото", message: "", imageData: imageData) { text, imageData, errors in
            if let errors = errors {
                Picker.defaultPicker.errorsAlert(showIn: self, error: errors)
            } else {
                let filePath = self.fileService.path + "/" + text! + ".png"

                let fileData = imageData
                do {
                    try fileData?.write(to: URL(filePath: filePath), options: .withoutOverwriting)
                } catch {
                    Picker.defaultPicker.errorsAlert(showIn: self, error: .nameExist)
                }
                self.tableView.reloadData()
            }
        }
    }
}
