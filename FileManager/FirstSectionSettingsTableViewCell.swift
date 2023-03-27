//
//  SettingsTableViewCell.swift
//  FileManager
//
//  Created by Aleksandr Derevyanko on 27.03.2023.
//

import Foundation
import UIKit

class FirstSectionSettingsTableViewCell: UITableViewCell {
    
    var value: String?
    static let notificationName = NSNotification.Name("SwitchChange")
    
    struct ViewModel {
        var title: String
        var value: String
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let settingsSwitch: UISwitch = {
        let settingsSwitch = UISwitch()
        settingsSwitch.translatesAutoresizingMaskIntoConstraints = false
        return settingsSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        settingsSwitch.isOn = UserDefaults.standard.bool(forKey: viewModel.value)
        self.value = viewModel.value
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(settingsSwitch)
        setupConstraints()
        addTargets()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(20)
            make.right.equalTo(settingsSwitch.snp.left).offset(-20)
        }
        settingsSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.right.equalTo(-20)
        }
    }
    
    private func addTargets() {
        settingsSwitch.addTarget(self, action: #selector(settingsSwitchValueChanged), for: .valueChanged)
    }
    
    @objc
    private func settingsSwitchValueChanged() {
        if UserDefaults.standard.bool(forKey: value ?? "") {
            UserDefaults.standard.set(false, forKey: value ?? "")
            NotificationCenter.default.post(name: FirstSectionSettingsTableViewCell.notificationName, object: nil)
        } else {
            UserDefaults.standard.set(true, forKey: value ?? "")
            NotificationCenter.default.post(name: FirstSectionSettingsTableViewCell.notificationName, object: nil)
        }
    }
    
}
