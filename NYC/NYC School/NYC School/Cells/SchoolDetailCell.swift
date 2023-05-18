//
//  SchoolDetailCell.swift
//  NYC School
//
//  Created by Manohar on 5/14/23.
//

import Foundation
import UIKit

class SchoolDetailCell: UITableViewCell {
    static let identifier = "schoolDetailCell"
    
    private lazy var schoolNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setupView() {
        selectionStyle = .blue
        
        self.contentView.addSubview(schoolNameLabel)
        schoolNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        schoolNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        schoolNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        schoolNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        schoolNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
    }
    
    func setup(schoolName: String) {
        schoolNameLabel.text = schoolName
    }
}
