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
        
        // Fetches the appropriate item for the data source layout.
        let item = items[indexPath.row]
        
        cell.titleLabel.text = item.title
        
        cell.descriptionLabel.text = item.text
        cell.descriptionLabel.lineBreakMode = .byTruncatingTail
        cell.descriptionLabel.numberOfLines = 0
        cell.descriptionLabel.textAlignment = .natural
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        cell.dateLabel.text = formatter.string(from: item.date)
        
        cell.photoImageView.image = item.image
        
        return cell
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "ShowDetail":
            guard let rssItemViewController = segue.destination as? RssItemViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCell = sender as? RssTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedItem = items[indexPath.row]
            rssItemViewController.item = selectedItem
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

    
    //MARK: Private methods
    private func loadItems() {
        items.removeAll()
        items.append(RssItem(title: "hi", text: "hello world! here", date: Date(), image: #imageLiteral(resourceName: "defaultPhoto")))
        items.append(RssItem(title: "hello", text: "hello world. this is a very long description here. tralalalallalalasdfsdfsdfalla lsadfl asldf lasdfl asdlf lasdf lasdfl asdlf saldf ladsfl lsadfl sdf lsdf lsdf lsdlf lsdfl sdlf ldsf lsadfl ldsf", date: Date(), image: #imageLiteral(resourceName: "defaultPhoto")))
    }
}
