//
//  RssItem.swift
//  AppleRssViewer
//
//  Created by Ivan Yurchenko on 5/9/17.
//  Copyright © 2017 Ivan Yurchenko. All rights reserved.
//

import UIKit

class RssItem {
    var title: String
    var image: UIImage?
    
    init?(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
}
