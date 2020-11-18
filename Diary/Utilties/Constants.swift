//
//  Constants.swift
//  Diary
//
//  Created by Mayuri Shekhar on 01/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import Foundation
import UIKit
    
    struct NoteViewCell
    {
        static let CellReuseIdentifier = "DiaryCell"
        static let nibName = "NoteTableViewCell"
    }

struct Theme
{
    struct Background {
    
    static let lightTheme : UIColor =  UIColor(red: 255.0/255.0, green: 221.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    static let darkTheme : UIColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 41.0/255.0, alpha: 0.5)
    static let noteBookTheme : UIColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 210.0/255.0, alpha: 1.0)
    }
    
    struct Alert {
        
        static let lightTheme : UIColor =  UIColor(red: 255.0/255.0, green: 249.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        static let darkTheme : UIColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 41.0/255.0, alpha: 0.5)
        static let noteBookTheme : UIColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 210.0/255.0, alpha: 1.0)
    }
    
    
}


struct Current {
    static var backgroundColor : UIColor = Theme.Background.noteBookTheme
    static var alertBackgroundColor : UIColor = Theme.Alert.lightTheme
    static var lastNoteID : Int = 0
}

struct VC {
    static let home = "homeViewController"
    static let noteDetailVC = "NewNoteViewController"
    static let saveNote = "SaveNoteViewController"
    
}

struct DB
{
    static let notAvailable = "notAvailable"
    static let noteID = "noteID"
    static let emoji = "emoji"
    static let imageAttachment = "imageAttachment"
    static let noteDescription = "noteDescription"
    static let  savingDate = "savingDate"
    static let savingTime = "savingTime"
    static let title = "title"
    
}

struct Nib {
    static let saveNoteAlert = "SaveNote"
    static let deleteImagePopup = "DeleteImage"
    static let imageAttachmentPopup = "ImageAttachmentPopup"
    static let emojiPopup = "EmojiPopup"
    static let moreMenuPopup = "MoreMenuPopup"
    static let sortPopup = "SortPopupView"
   
}

struct  KEYS {
    static let keyCurrentTheme = "keyCurrentTheme"
}
