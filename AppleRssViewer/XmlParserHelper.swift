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
    var feeds: [Any] = [Any]()
    var elements: [String:String] = [String:String]()
    var element = String()
    var title = String()
    var link = String()
    var img:  [AnyObject] = []
    var descriptionString = String()
    var date = String()
    
    // initilise parser
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
        if (element == "item") {
            elements = [:]
            title = ""
            link = ""
            descriptionString = ""
            date = ""
        } else if (element == "enclosure") {
            if let urlString = attributeDict["url"] {
                img.append(urlString as AnyObject)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName == "item") {
            if title != "" {
                elements["title"] = title
            }
            
            if link != "" {
                elements["link"] = link
            }
            
            if descriptionString != "" {
                elements["description"] = descriptionString
            }
            
            if date != "" {
                elements["pubDate"] = date
            }
            
            feeds.append(elements)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if (element == "title") {
            title.append(string)
        } else if (element == "link") {
            link.append(string)
        } else if (element == "description") {
            descriptionString.append(string)
        } else if (element == "pubDate") {
            date.append(string)
        }
    }
}
