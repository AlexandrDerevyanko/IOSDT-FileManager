//
//  SecondSectionSettingsTableViewCell.swift
//  FileManager
//
//  Created by Aleksandr Derevyanko on 27.03.2023.
//

import UIKit

class SecondSectionSettingsTableViewCell: UITableViewCell {
    
    struct ViewModel {
        var title: String
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
    }
    
}
