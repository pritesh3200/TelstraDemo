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
    var activityIndicatorView: UIActivityIndicatorView!
    
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
        
        imageIconView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        imageIconView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        imageIconView.widthAnchor.constraint(equalToConstant:70).isActive = true
        imageIconView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.imageIconView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor,constant:-10).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor).isActive = true
        
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        self.activityIndicatorView = activityIndicatorView
        self.activityIndicatorView.frame = CGRect(x: 30, y: 30, width: 20, height: 20)
        self.imageIconView.center = activityIndicatorView.center
        activityIndicatorView.startAnimating()
        self.imageIconView.addSubview(activityIndicatorView)
        
    }
   
    // MARK: - Declared Computed properties
    let imageIconView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  _ColorLiteralType(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  _ColorLiteralType(red: 1, green: 1, blue: 1, alpha: 1)
        label.backgroundColor =  _ColorLiteralType(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true 
        return view
    }()

}
