//
//  Constant.swift
//  TelstraDemo
//
//  Created by Pritesh on 02/12/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

struct GetURL {
     static let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
}
struct Font {
    struct TableViewCell {
         static let TitleFont = UIFont.boldSystemFont(ofSize: 20)
         static let DescriptionFont = UIFont.boldSystemFont(ofSize: 14)
    }
}

struct ConstraintConstant {
    struct TableViewCell {
        static let ImageLeading = CGFloat(10)
        static let ImageWidth   = CGFloat(70)
        static let ImageHeight  = CGFloat(70)
        
        static let ContainerViewLeading   = CGFloat(10)
        static let ContainerViewTrailing  = CGFloat(-10)
        static let ContainerViewBottom    = CGFloat(-20)
        
        static let ActivityViewX = CGFloat(30)
        static let ActivityViewY = CGFloat(30)
        static let ActivityViewW = CGFloat(20)
        static let ActivityViewH = CGFloat(20)
    }
    
    struct ViewController {
        struct CanadaDataVC {
            static let ActivityViewW = CGFloat(20)
            static let ActivityViewH = CGFloat(20)
        }
    }
}

struct StaticString {
    struct ViewModel {
        struct CountryInfoViewModel {
             static let TitleEmpty       = "Title not available"
             static let DescriptionEmpty = "Description not available"
        }
    }
}


