//
//  Item.swift
//  Todey
//
//  Created by Harsh Khetarpal on 15/01/19.
//  Copyright © 2019 Harsh Khetarpal. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    //It represents zero or more objects that are linked to its owning model object through a property relationship.
    // proprt will be the name of variable which we define in Category class
    
    let parentCategory = LinkingObjects.init(fromType: Category.self, property: "item")
    
}
