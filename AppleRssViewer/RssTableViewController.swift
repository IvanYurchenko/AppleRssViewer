//
//  RssTableViewController.swift
//  AppleRssViewer
//
//  Created by Ivan Yurchenko on 5/9/17.
//  Copyright © 2017 Ivan Yurchenko. All rights reserved.
//

import UIKit

class RssTableViewController: UITableViewController {
    
    // MARK: Properties
    var items = [RssItem]()
    var imageUrls: [String] = []
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://feeds.skynews.com/feeds/rss/technology.xml")!
        
        // ------- Uncomment next line to view Apple News RSS: -------
        // url = URL(string: "http://developer.apple.com/news/rss/news.rss")!
        
        loadRss(url)
    }
    
    // MARK: Table view data source
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
        cell.dateLabel.text = item.date
        cell.photoImageView.image = item.image
        
        return cell
    }
    
    // MARK: Navigation
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
    
    
    // MARK: Private methods
    private func loadRss(_ data: URL) {
        // XmlParserHelper instance/object/variable
        let myParser = XmlParserHelper(data)
        
        // Put feed in array
        imageUrls = myParser.imageUrls
        items = myParser.items
        
        for i in 0...(items.count - 1) {
            items[i].image = imageByIndex(index: i)
        }
        
        tableView.reloadData()
    }
    
    private func imageByIndex(index: Int) -> UIImage {
        if(imageUrls.count > 0) {
            let url = NSURL(string: imageUrls[index])
            let data = NSData(contentsOf: url! as URL)
            let image = UIImage(data:data! as Data)
            return image ?? #imageLiteral(resourceName: "defaultPhoto")
        } else {
            return #imageLiteral(resourceName: "defaultPhoto")
        }
    }
}
