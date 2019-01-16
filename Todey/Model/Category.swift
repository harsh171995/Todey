//
//  Category.swift
//  Todey
//
//  Created by Harsh Khetarpal on 15/01/19.
//  Copyright © 2019 Harsh Khetarpal. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var title : String = ""
    
    //List is the container type in Realm used to define to-many relationships.
    let item = List<Item>()
}
