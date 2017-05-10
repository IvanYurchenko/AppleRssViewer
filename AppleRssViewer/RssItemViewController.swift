//
//  RssItemViewController.swift
//  AppleRssViewer
//
//  Created by Ivan Yurchenko on 5/9/17.
//  Copyright © 2017 Ivan Yurchenko. All rights reserved.
//

import UIKit

class RssItemViewController: UIViewController, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    var item: RssItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 0
        
        if let item = item {
            titleLabel.title = item.title
            photoImageView.image = item.image
            textLabel.text = item.text
        }
    }
}
