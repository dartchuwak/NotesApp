//
//  NotesTableViewCell.swift
//  NotesApp
//
//  Created by Evgenii Mikhailov on 01.02.2023.
//

import UIKit
import SnapKit

class NotesTableViewCell: UITableViewCell {
    
    var color: UIColor?
    var fontSize: CGFloat?
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel.font = UIFont.boldSystemFont(ofSize: fontSize ?? 24)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        self.layer.cornerRadius = 15
        self.selectionStyle = .none
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).inset(-10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
