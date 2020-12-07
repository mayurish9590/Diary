//
//  ThemeTableViewCell.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 26/11/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit

class ThemeTableCell: UITableViewCell {
   
    @IBOutlet weak var txt: UILabel!
    @IBOutlet weak var forground: UIView!
    @IBOutlet weak var bg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
    func  configureCell(theme: Themes) {
           
           self.bg.layer.cornerRadius = 10
           self.bg.layer.borderColor = theme.Text.cgColor
           self.bg.layer.borderWidth = 2
           
           self.forground.layer.cornerRadius = 10
           self.forground.layer.borderColor = theme.Text.cgColor
           self.forground.layer.borderWidth = 2
           
      self.bg.backgroundColor = theme.background
           self.forground.backgroundColor = theme.foreground
           self.txt.textColor = theme.Text
           self.txt.text = theme.name
           //self.loackImage.isHidden = !theme.isLocked
       }}
