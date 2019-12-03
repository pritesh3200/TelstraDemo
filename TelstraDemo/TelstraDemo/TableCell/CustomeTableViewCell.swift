//
//  CustomeTableViewCell.swift
//  TelstraDemo
//
//  Created by Pritesh on 26/11/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class CustomeTableViewCell: UITableViewCell {
    
    // MARK: - Declared Property
    static let cellIdentifire = "countryDataCell"
    static let defaultImageName = "default_icon"
    static let imageCRadius = CGFloat(35)
    static let descriptionCRadius = CGFloat(5)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Reuse Outlet
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.titleLabel.text?.removeAll()
        self.descriptionLabel.text?.removeAll()
        self.imageIconView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imageIconView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        self.contentView.addSubview(containerView)
        self.imageIconView.addSubview(activityIndicator)
        
        imageIconView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        imageIconView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:ConstraintConstant.TableViewCell.ImageLeading).isActive = true
        imageIconView.widthAnchor.constraint(equalToConstant:ConstraintConstant.TableViewCell.ImageWidth).isActive = true
        imageIconView.heightAnchor.constraint(equalToConstant:ConstraintConstant.TableViewCell.ImageHeight).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.imageIconView.trailingAnchor, constant:ConstraintConstant.TableViewCell.ContainerViewLeading).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:ConstraintConstant.TableViewCell.ContainerViewTrailing).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor,constant:ConstraintConstant.TableViewCell.ContainerViewBottom).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor).isActive = true
        
        let xConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self.imageIconView, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self.imageIconView, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([xConstraint, yConstraint])
        
    }
    
    // MARK: - Declared Computed properties
    let imageIconView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = imageCRadius
        img.clipsToBounds = true
        return img
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.TableViewCell.TitleFont
        label.textColor = UIColor.Black.BoldBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Font.TableViewCell.DescriptionFont
        label.textColor = UIColor.White.CustomWhite
        label.backgroundColor = UIColor.Blue.SkyBlue
        label.layer.cornerRadius = descriptionCRadius
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
}
