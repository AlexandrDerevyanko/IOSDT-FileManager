//
//  SettingsViewController.swift
//  FileManager
//
//  Created by Aleksandr Derevyanko on 27.03.2023.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(FirstSectionSettingsTableViewCell.self, forCellReuseIdentifier: "FirstSettingsCell")
        tableView.register(SecondSectionSettingsTableViewCell.self, forCellReuseIdentifier: "SecondSettingsCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints({ make in
            make.edges.equalTo(view)
        })
    }
    
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return boolSettingsArray.count
        } else {
            return settingsArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstSettingsCell", for: indexPath) as? FirstSectionSettingsTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            let viewModel = FirstSectionSettingsTableViewCell.ViewModel(title: boolSettingsArray[indexPath.row].title, value: boolSettingsArray[indexPath.row].value ?? "")
            cell.setup(viewModel)
            let switchView = cell.settingsSwitch
            switchView.tag = indexPath.row
            cell.accessoryView = switchView
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondSettingsCell", for: indexPath) as? SecondSectionSettingsTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            let viewModel = SecondSectionSettingsTableViewCell.ViewModel(title: settingsArray[indexPath.row].title)
            cell.setup(viewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            SettingsData.defaultSettingsData.changePassword(showIn: self)
        }
    }
    
}
