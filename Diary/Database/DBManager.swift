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
 
    static func saveToDB(note: NoteModel)
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
          
        let noteObj = NSManagedObject(entity: entity, insertInto: managedContext)
          
          
         
        noteObj.setValue(note.noteID, forKeyPath: DB.noteID)
        noteObj.setValue(note.title, forKeyPath: DB.title)
        noteObj.setValue(note.emoji, forKeyPath: DB.emoji)
        noteObj.setValue(note.noteDescription, forKeyPath: DB.noteDescription)
      noteObj.setValue(note.imageAttachment, forKey: DB.imageAttachment)
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
    static func fetchAllNote() -> [NoteModel]?
    {
     
        var notes : [Note] = []
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil}
      
    let managedContext = appDelegate.persistentContainer.viewContext
                
    nsobjContext = managedContext
    
    let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        do {
          notes = try managedContext.fetch(fetchRequest)
              } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
         }
        var noteModel: [NoteModel] = []
        for note in notes {
            noteModel.append(NoteModel(emoji: note.emoji
                , imageAttachment: note.imageAttachment, noteDescription: note.noteDescription, noteID: Int(note.noteID), savingDate: note.savingDate!, savingTime: note.savingTime, title: note.title
            ))
        }
        
        
        return noteModel
    }
    
    static func delete(note : NoteModel)
    {
       guard let appDelegate =
              UIApplication.shared.delegate as? AppDelegate else {
              return
            }
   
    let managedContext =
              appDelegate.persistentContainer.viewContext
     
       
        
        var noteObj  : [Note] = []
       let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "%K == %@ AND %K == %@ AND %K == %@", argumentArray: [DB.title, note.title!, DB.savingDate, note.savingDate, DB.noteDescription, note.noteDescription!])
        
  do {
                 noteObj = try managedContext.fetch(fetchRequest)
                     } catch let error as NSError {
                       print("Could not fetch. \(error), \(error.userInfo)")
                }
    
        if (noteObj.count != 0){
        
           managedContext.delete(noteObj.first!)
          
        }
    }
   
    
    
    static func update(note : Note)
    {
      /* guard let appDelegate =
                    UIApplication.shared.delegate as? AppDelegate else {
                    return
                  }
         
          let managedContext =
                    appDelegate.persistentContainer.viewContext
        
     let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
       
      */
        
    }
    
   static func sortbyAToZ() -> [NoteModel]?
    {
        
        var notes : [Note] = []
        
       guard let appDelegate =
                  UIApplication.shared.delegate as? AppDelegate else {
                  return nil
                }
       
        let managedContext =
                  appDelegate.persistentContainer.viewContext
      
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: DB.title, ascending: true), NSSortDescriptor(key: DB.noteDescription, ascending: true)]
          
        
        do {
               notes = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
                     print("Could not fetch. \(error), \(error.userInfo)")
              }
             var noteModel: [NoteModel] = []
             for note in notes {
                 noteModel.append(NoteModel(emoji: note.emoji
                     , imageAttachment: note.imageAttachment, noteDescription: note.noteDescription, noteID: Int(note.noteID), savingDate: note.savingDate!, savingTime: note.savingTime, title: note.title
                 ))
             }
        return noteModel
    }
        
    
    
    
 static   func sortByZtoA() -> [NoteModel]?
    {
        
        var notes : [Note] = []
        guard let appDelegate =
                    UIApplication.shared.delegate as? AppDelegate else {
                    return nil
                  }
         
          let managedContext =
                    appDelegate.persistentContainer.viewContext
        
          let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: DB.title, ascending: false),NSSortDescriptor(key: DB.noteDescription, ascending: false)]
            
          
          do {
                 notes = try managedContext.fetch(fetchRequest)
              
          } catch let error as NSError {
                       print("Could not fetch. \(error), \(error.userInfo)")
                }
               var noteModel: [NoteModel] = []
               for note in notes {
                   noteModel.append(NoteModel(emoji: note.emoji
                       , imageAttachment: note.imageAttachment, noteDescription: note.noteDescription, noteID: Int(note.noteID), savingDate: note.savingDate!, savingTime: note.savingTime, title: note.title
                   ))
               }
          return noteModel
    }
      
    
    
    
    
    
    
    }
    

