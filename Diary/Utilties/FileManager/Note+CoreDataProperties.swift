//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Mayuri Shekhar on 12/11/20.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var emoji: String?
    @NSManaged public var imageAttachment: Bool
    @NSManaged public var noteDescription: String?
    @NSManaged public var noteID: String?
    @NSManaged public var savingDate: Date?
    @NSManaged public var savingTime: String?
    @NSManaged public var title: String?

}
