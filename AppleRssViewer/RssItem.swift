//
//  RssItem.swift
//  AppleRssViewer
//
//  Created by Ivan Yurchenko on 5/9/17.
//  Copyright © 2017 Ivan Yurchenko. All rights reserved.
//

import UIKit

/**
 An item that represents an RSS feed unit.
 */
class RssItem {
    
    // MARK: Properties
    var title: String
    var text: String
    var image: UIImage?
    var date: String
    
    // MARK: Initializer
    init(title: String, text: String, date: String, image: UIImage?) {
        self.title = title
        self.text = text
        self.date = date
        self.image = image
    }
}
