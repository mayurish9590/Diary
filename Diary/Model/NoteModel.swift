//
//  NoteModel.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 04/11/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import Foundation
struct NoteModel {
    var emoji: String
    var imageAttachment: Bool = false
    var noteDescription: String
    var noteID: Int64
    var savingDate: Date
    var savingTime: String
    var title: String
}
