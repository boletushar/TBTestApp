//
//  FactTableViewCell.swift
//  TBTestApp
//
//  Created by Tushar Bole on 7/2/20.
//  Copyright © 2020 Tushar Bole. All rights reserved.
//

import UIKit
import Kingfisher

final class FactTableViewCell: UITableViewCell {
    
    let padding: CGFloat = 10
    let imageWidth: CGFloat = 60
    let imageHeight: CGFloat = 60
    
    private let factTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .natural
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let factDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let factImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 60, height: 60))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(factImageView)
        addSubview(factTitleLabel)
        addSubview(factDescriptionLabel)
        
        let constraint = [
            factImageView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: padding),
            factImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: padding),
            factImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            factImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            factImageView.bottomAnchor.constraint(
                lessThanOrEqualTo: bottomAnchor,
                constant: -padding),

            factTitleLabel.topAnchor.constraint(
                equalTo: factImageView.topAnchor),
            factTitleLabel.leadingAnchor.constraint(
                equalTo: factImageView.trailingAnchor,
                constant: padding),
            factTitleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -padding),

            factDescriptionLabel.topAnchor.constraint(
                equalTo: factTitleLabel.bottomAnchor,
                constant: padding/2),
            factDescriptionLabel.leadingAnchor.constraint(
                equalTo: factTitleLabel.leadingAnchor),
            factDescriptionLabel.trailingAnchor.constraint(
                equalTo: factTitleLabel.trailingAnchor),
            factDescriptionLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -padding),
            ]
        
        NSLayoutConstraint.activate(constraint)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        factImageView.image = nil
    }
    
    func configure(_ fact: Fact) {
        factTitleLabel.text = fact.title
        factDescriptionLabel.text = fact.description
        
        if let url = URL(string: fact.imageHref ?? "") {
            factImageView.kf.setImage(with: url)
        }
    }
}
