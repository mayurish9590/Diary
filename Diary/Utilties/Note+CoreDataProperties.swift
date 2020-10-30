//
//  Note+CoreDataProperties.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 28/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var emoji: String?
    @NSManaged public var imageAttachment: Data?
    @NSManaged public var noteDescription: String?
    @NSManaged public var noteID: Int64
    @NSManaged public var savingDate: String?
    @NSManaged public var savingTime: String?
    @NSManaged public var title: String?

}
