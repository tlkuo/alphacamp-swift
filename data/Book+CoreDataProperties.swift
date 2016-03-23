//
//  Book+CoreDataProperties.swift
//  alphacamp-swift
//
//  Created by martin on 2016/3/23.
//  Copyright © 2016年 Frainbow. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Book {

    @NSManaged var name: String?
    @NSManaged var author: String?

}
