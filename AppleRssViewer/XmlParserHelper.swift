//
//  XmlParserHelper.swift
//  AppleRssViewer
//
//  Created by Ivan Yurchenko on 5/10/17.
//  Copyright © 2017 Ivan Yurchenko. All rights reserved.
//

import Foundation

class XmlParserHelper: NSObject, XMLParserDelegate {
    
    var parser = XMLParser()
    var feeds: [RssItem] = [RssItem]()
    var element = String()
    var title = String()
    var link = String()
    var img:  [AnyObject] = []
    var descriptionString = String()
    var date = String()
    
    // initialize parser
    func initWithURL(_ url :URL) -> AnyObject {
        startParse(url)
        return self
    }
    
    func startParse(_ url: URL) {
        feeds = []
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName
        switch element {
        case "item":
            title = ""
            link = ""
            descriptionString = ""
            date = ""
        case "enclosure":
            if let urlString = attributeDict["url"] {
                img.append(urlString as AnyObject)
            }
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
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
        
        guard elementName == "item",
            title != "",
            link != "",
            descriptionString != "",
            date != ""
            else { return }
        
        let item = RssItem(title: title, text: descriptionString, date: date, image: nil)
        feeds.append(item)
    }
}
