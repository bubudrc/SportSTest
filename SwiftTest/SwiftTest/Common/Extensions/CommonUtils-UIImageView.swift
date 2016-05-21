//
//  CommonUtils-UIImageView.swift
//  SwiftTest
//
//  Created by Marcelo Perretta  on 5/20/16.
//  Copyright © 2016 Sports Illustrated. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


extension UIImageView {
    
    public func imageFromUrl(link link: String, placeholderImage placeholder: UIImage? = nil) {
        guard let url = NSURL(string: link) else {return}
        self.af_setImageWithURL(url, placeholderImage: placeholder)
    }
}

