//
//  EventsTableViewCell.swift
//  FileManager
//
//  Created by Aleksandr Derevyanko on 23.03.2023.
//

import Foundation

import UIKit

class FilesTableViewCell: UITableViewCell {
    
    struct ViewModel {
        var title: String
        var description: String?
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
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
        descriptionLabel.text = viewModel.description
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(descriptionLabel).offset(-16)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(-16)
        }
        
    }
    
}
