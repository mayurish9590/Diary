//
//  NoteTableViewCell.swift
//  Diary
//
//  Created by Mayuri Shekhar on 28/09/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit
import Foundation
class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var bacgroundImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
   
    @IBOutlet weak var dateLabel: UILabel!
  
    @IBOutlet weak var desciptionLabel: UILabel!
    
    @IBOutlet weak var descriptionViewConstaints: NSLayoutConstraint!
    @IBOutlet weak var emojiImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        }
    
   
    
    
}
