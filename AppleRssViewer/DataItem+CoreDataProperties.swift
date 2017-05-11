//
//  DataItem+CoreDataProperties.swift
//  AppleRssViewer
//
//  Created by Ivan Yurchenko on 5/11/17.
//  Copyright © 2017 Ivan Yurchenko. All rights reserved.
//

import Foundation
import CoreData


extension DataItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataItem> {
        return NSFetchRequest<DataItem>(entityName: "DataItem")
    }

    @NSManaged public var date: String?
    @NSManaged public var image: NSData?
    @NSManaged public var text: String?
    @NSManaged public var title: String?

}
