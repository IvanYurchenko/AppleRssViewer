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
    var text: String
    var image: UIImage?
    
    init(title: String, text: String, image: UIImage?) {
        self.title = title
        self.text = text
        self.image = image
    }
}
