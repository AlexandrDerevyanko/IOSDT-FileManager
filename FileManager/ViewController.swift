//
//  ViewController.swift
//  FileManager
//
//  Created by Aleksandr Derevyanko on 17.03.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    var documents: [String] {
        do {
            return try FileManager.default.contentsOfDirectory(atPath: path)
        } catch {
            print(error)
        }
        return []
    }
    
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
        tableView.register(EventsTableViewCell.self, forCellReuseIdentifier: "EventCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .cyan
        view.addSubview(tableView)
        setupConstraints()
        setupButtons()
        navigationItem.title = NSString(string: path).lastPathComponent
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints({ make in
            make.edges.equalTo(view)
        })
    }
    
    func setupButtons() {
        let addPhotoButton = UIBarButtonItem(title: "Add photo", style: .plain, target: self, action: #selector(addPhotoButtonPressed))
        navigationItem.rightBarButtonItem = addPhotoButton
    }
    
    @objc
    private func addPhotoButtonPressed() {
        present(picker, animated: true)
    }
        
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventsTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        let viewModel = EventsTableViewCell.ViewModel(title: documents[indexPath.row])
        cell.setup(viewModel)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pathToItem = path + "/" + documents[indexPath.row]
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

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageData = image.pngData()
        self.dismiss(animated: true)
        Picker.defaultPicker.getImage(showPickerIn: self, title: "Enter image title", message: "", imageData: imageData) { text, imageData in
            let filePath = self.path + "/" + text + ".png"

            let fileData = imageData
            do {
                try fileData.write(to: URL(filePath: filePath))
            } catch {
                print(error)
            }
            self.tableView.reloadData()
        }
    }

}
