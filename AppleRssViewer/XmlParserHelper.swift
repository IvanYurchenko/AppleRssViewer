//
//  XmlParserHelper.swift
//  AppleRssViewer
//
//  Created by Ivan Yurchenko on 5/10/17.
//  Copyright © 2017 Ivan Yurchenko. All rights reserved.
//

import Foundation

/**
 A class that allows to parse XML from given URL to return an array of items as a result.
 */
class XmlParserHelper: NSObject, XMLParserDelegate {
    
    // MARK: Properties
    var parser = XMLParser()
    
    // The collection that will be used as a result
    var items: [RssItem] = [RssItem]()
    
    // An array containing urls to images for further processing
    var imageUrls:  [String] = []
    
    // An element that is currently processing
    var element = String()
    
    // Properties for RssItem
    var title = String()
    var link = String()
    var descriptionString = String()
    var date = String()
    
    // MARK: Initializer
    init(_ url: URL) {
        super.init()
        startParse(url)
    }
    
    // MARK: XMLParserDelegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        // Save the currently processing element's name
        element = elementName
        
        switch element {
        case "item":
            // If it's an item reset the properties for it
            title = ""
            link = ""
            descriptionString = ""
            date = ""
        case "enclosure":
            // Get a URL link from attributes dictionary
            if let urlString = attributeDict["url"] {
                imageUrls.append(urlString)
            }
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // Depending on what we are currently processing append data to needed property
        switch element {
        case "title":
            title.append(string)
        case "link":
            link.append(string)
        case "description":
            descriptionString.append(string)
        case "pubDate":
            date.append(string)
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        // If something's incorrect don't add this item
        guard elementName == "item",
            title != "",
            link != "",
            descriptionString != "",
            date != ""
            else { return }
        
        // Create an RssItem and add it to the resulting array
        let item = RssItem(title: title, text: descriptionString, date: date, image: nil)
        items.append(item)
    }
    
    // MARK: Private methods
    /**
     Starts parsing XML from given URL and appends results to the items array
     */
    private func startParse(_ url: URL) {
        
        // Reset items array
        items = []
        
        // Create a new parser
        parser = XMLParser(contentsOf: url)!
        
        // Set parser's delegate to self to use possibilities of the  XMLParserDelegate protocol that we implemented
        parser.delegate = self
        
        // Configure parser
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        
        // Start parsing
        parser.parse()
    }
}
