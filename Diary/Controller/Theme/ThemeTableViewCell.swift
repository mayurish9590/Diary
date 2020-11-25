//
//  ThemeTableViewCell.swift
//  Dairy
//
//  Created by Swapnil Waghmare on 02/11/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit

class ThemeTableViewCell: UITableViewCell {

    @IBOutlet weak var themeName: UILabel!
    @IBOutlet weak var foregroundColorView: UIView!
    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var loackImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func  configureCell(theme: Themes) {
        
        self.viewContainer.layer.cornerRadius = 10
        self.viewContainer.layer.borderColor = theme.Text.cgColor
        self.viewContainer.layer.borderWidth = 2
        self.backgroundImage.image = theme.background
        self.foregroundColorView.layer.cornerRadius = 10
        self.foregroundColorView.layer.borderColor = theme.Text.cgColor
        self.foregroundColorView.layer.borderWidth = 2
        
        self.viewContainer.backgroundColor = .blue
        self.foregroundColorView.backgroundColor = theme.foreground
        self.themeName.textColor = theme.Text
        self.themeName.text = theme.name
        //self.loackImage.isHidden = !theme.isLocked
    }

}
