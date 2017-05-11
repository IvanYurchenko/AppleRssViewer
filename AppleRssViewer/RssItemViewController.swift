//
//  RssItemViewController.swift
//  AppleRssViewer
//
//  Created by Ivan Yurchenko on 5/9/17.
//  Copyright © 2017 Ivan Yurchenko. All rights reserved.
//

import UIKit

class RssItemViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!

    // The item that will be passed by RssTableViewController to show its details
    var item: RssItem?
    
    // MARK: Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show details of the retrieved item
        if let item = item {
            titleLabel.title = item.title
            photoImageView.image = item.image
            textLabel.text = item.text
            dateLabel.text = item.date
        }
    }
}
