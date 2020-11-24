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
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var backgroundImageHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var dateLabel: UILabel!
  
    @IBOutlet weak var desciptionLabel: UILabel!
    
    @IBOutlet weak var emojiImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

            
      //  self.contentView.backgroundColor = Themes.currentTheme().alert
        self.dateLabel.textColor = Themes.currentTheme().Text
         self.titleLabel.textColor = Themes.currentTheme().Text
         self.desciptionLabel.textColor = Themes.currentTheme().Text
        
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.borderColor = UIColor.white.cgColor
        self.containerView.layer.borderWidth = 2
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        }
    
    func configureCell(note: NoteModel)  {
        self.emojiImageView.image = UIImage(named: note.emoji)
        self.titleLabel.text = note.title
        self.desciptionLabel.text = note.noteDescription
        let  formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
        self.dateLabel.text = formatter.string(from: note.savingDate)
        if note.imageAttachment {
            self.backgroundImageHeightConstraint.constant = 100
            self.bacgroundImageView.image = ImageStorage.loadImageFromDiskWith(imageName: note.noteID)
        } else {
            self.backgroundImageHeightConstraint.constant = 0
        }
    }
   
    
    
}
