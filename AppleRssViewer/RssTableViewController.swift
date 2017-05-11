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
        
        // Loads data from given URL and displays it in the table
        loadData(url)
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
        
        // Configure titleLabel from item's data
        cell.titleLabel.text = item.title
        
        // Configure descriptionLabel from item's data
        cell.descriptionLabel.text = item.text
        cell.descriptionLabel.textAlignment = .natural
        
        // Configure dateLabel from item's data
        cell.dateLabel.text = item.date
        
        // Configure photoImageView from item's data
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
            
            // Get an item that was selected
            let selectedItem = items[indexPath.row]
            
            // Pass the selected item to the viewController so we can see it's details
            rssItemViewController.item = selectedItem
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    // MARK: Private methods
    /**
        Parses the XML from given URL to items collection and downloads appropriate images for items.
    */
    private func loadData(_ data: URL) {
        // Create an XmlParserHelper that will start process data
        let myParser = XmlParserHelper(data)
        
        // Get results from parser
        imageUrls = myParser.imageUrls
        items = myParser.items
        
        // Retrieve images from URL's for each item individually
        for i in 0...(items.count - 1) {
            items[i].image = imageByIndex(index: i)
        }
        
        tableView.reloadData()
    }
    
    /**
        Retrieves image by URL from imageUrls array. If there's no URLs or if an image can not be retrieved return a default image.
     */
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
