//
//  Item.swift
//  StoreApp
//
//  Created by Kongeshwaran on 23/01/18.
//  Copyright © 2018 user908662. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
    
}
