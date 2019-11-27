//
//  UIImageViewExtention.swift
//  TelstraDemo
//
//  Created by Pritesh on 26/11/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, activityIndicator: UIActivityIndicatorView) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async {
                      activityIndicator.stopAnimating()
                    }
                    
                    return
                }
            
            DispatchQueue.main.async() {
                self.image = image
                activityIndicator.stopAnimating()
            }
            }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, loader: UIActivityIndicatorView) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, activityIndicator: loader)
    }
}
