//
//  Category.swift
//  StoreApp
//
//  Created by Kongeshwaran on 23/01/18.
//  Copyright © 2018 user908662. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
