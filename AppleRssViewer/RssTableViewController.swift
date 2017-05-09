//
//  RssTableViewController.swift
//  AppleRssViewer
//
//  Created by Ivan Yurchenko on 5/9/17.
//  Copyright © 2017 Ivan Yurchenko. All rights reserved.
//

import UIKit

class RssTableViewController: UITableViewController {
    var items = [RssItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RssTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RssTableViewCell else {
            fatalError("The dequeued cell is not an instance of RssTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let item = items[indexPath.row]
        
        cell.titleLabel.text = item.title
        
        cell.descriptionLabel.text = item.text
        cell.descriptionLabel.lineBreakMode = .byTruncatingTail
        cell.descriptionLabel.numberOfLines = 0
        cell.descriptionLabel.textAlignment = .natural
        
        cell.photoImageView.image = item.image
        
        return cell
    }
    
    //MARK: Private methods
    private func loadItems() {
        items.removeAll()
        items.append(RssItem(title: "hi", text: "hello world! here", image: #imageLiteral(resourceName: "defaultPhoto")))
        items.append(RssItem(title: "bye", text: "bye world. this is a very long description here. tralalalallalalasdfsdfsdfalla lsadfl asldf lasdfl asdlf lasdf lasdfl asdlf saldf ladsfl lsadfl sdf lsdf lsdf lsdlf lsdfl sdlf ldsf lsadfl ldsf", image: #imageLiteral(resourceName: "defaultPhoto")))
    }
}
