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
    var myFeed : [Any] = []
    var feedImgs: [AnyObject] = []
    var url: URL!
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        url = URL(string: "http://feeds.skynews.com/feeds/rss/technology.xml")!
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
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        cell.dateLabel.text = formatter.string(from: item.date)
        
        cell.photoImageView.image = imageByIndex(index: indexPath.row)
        
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
            
            selectedItem.image = imageByIndex(index: indexPath.row)
            rssItemViewController.item = selectedItem
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    // MARK: Private methods
    private func loadRss(_ data: URL) {
        // XmlParserHelper instance/object/variable
        let myParser : XmlParserHelper = XmlParserHelper().initWithURL(data) as! XmlParserHelper
        
        // Put feed in array
        feedImgs = myParser.img as [AnyObject]
        let foo = myParser.feeds as! [Dictionary<String, String>]
        var counter = 0
        items = foo.map { RssItem(title: $0["title"]!, text: $0["description"]!, date: Date(), image: #imageLiteral(resourceName: "defaultPhoto")
            ) }
        tableView.reloadData()
    }
    
    private func imageByIndex(index: Int) -> UIImage {
        if(feedImgs.count > 0) {
            let url = NSURL(string:feedImgs[index] as! String)
            let data = NSData(contentsOf:url! as URL)
            let image = UIImage(data:data! as Data)
            return image ?? #imageLiteral(resourceName: "defaultPhoto")
        } else {
            return #imageLiteral(resourceName: "defaultPhoto")
        }
    }
}
