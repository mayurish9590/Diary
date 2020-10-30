//
//  DBManager.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 20/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DMBManger {
    
   
    
   static var nsobjContext : NSManagedObjectContext?
 
    static func saveToDB(note : Note)
    {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
          }
          
          // 1
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
      nsobjContext = managedContext
          // 2
          let entity =
            NSEntityDescription.entity(forEntityName: "Note",
                                       in: managedContext)!
          
          let noteObj = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
          
          
         
        noteObj.setValue(note.noteID, forKeyPath: DB.noteID)
        noteObj.setValue(note.title, forKeyPath: DB.title)
        noteObj.setValue(note.emoji, forKeyPath: DB.emoji)
        noteObj.setValue(note.noteDescription, forKeyPath: DB.noteDescription)
        if note.imageAttachment != nil{
            noteObj.setValue(note.imageAttachment, forKey: DB.imageAttachment)}
        noteObj.setValue(note.savingDate, forKey: DB.savingDate)
        noteObj.setValue(note.savingTime, forKey: DB.savingTime)
        
        // 4
          do {
            try managedContext.save()
            print("saved in DB suceefully")
            //notes.append(note)
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
        
       
        
    }
    static func fetchAllNote() -> [Note]
    {
     
        var notes : [Note] = []
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return notes}
      
    let managedContext = appDelegate.persistentContainer.viewContext
                
    nsobjContext = managedContext
    
    let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        do {
          notes = try managedContext.fetch(fetchRequest)
              } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
         }
        
        return notes

    }
    
    static func delete(note : Note)
    {
       guard let appDelegate =
              UIApplication.shared.delegate as? AppDelegate else {
              return
            }
   
    let managedContext =
              appDelegate.persistentContainer.viewContext
      managedContext.delete(note)
    print("deleted from DB suceefully")
   
        
    }
   
    
    
    static func update(note : Note)
    {
       guard let appDelegate =
                    UIApplication.shared.delegate as? AppDelegate else {
                    return
                  }
         
          let managedContext =
                    appDelegate.persistentContainer.viewContext
        
     let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
       
        
        
    }
    
    
}
