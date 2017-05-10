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
    var date: Date
    
    init(title: String, text: String, date: Date, image: UIImage?) {
        self.title = title
        self.text = text
        self.date = date
        self.image = image
    }
}
