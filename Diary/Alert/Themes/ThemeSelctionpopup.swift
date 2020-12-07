//
//  ThemeSelctionpopup.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 26/11/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit
import Foundation
class ThemeSelctionpopup: UIView {
   
    
    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var themeTableView: UITableView!
    
    static let instance = ThemeSelctionpopup()
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       Bundle.main.loadNibNamed("ThemeSelctionView", owner: self, options: nil)
      initialSetup()
       
   }
   required init?(coder: NSCoder) {
       super.init(coder: coder)
       
   }
    
    
func initialSetup()
     {

        self.themeTableView.delegate = self
        self.themeTableView.dataSource = self
         parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
         parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
         
         let tapGesture = UITapGestureRecognizer(target: self,
                          action: #selector(dismissPopoup))
         parentView.addGestureRecognizer(tapGesture)
     }

   
      
        @objc func dismissPopoup() {
            parentView.endEditing(true)
            parentView.removeFromSuperview()
        }
     
      func showAlert() {
        
         Bundle.main.loadNibNamed("ThemeSelctionView", owner: self, options: nil)
             initialSetup()
        
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            
            window.addSubview(parentView
            )
           }
        self.themeTableView.reloadData()
        
    }
        
    }

 extension ThemeSelctionpopup: UITableViewDataSource {
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return Themes.numberOfRows()
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if let themeCell = tableView.dequeueReusableCell(withIdentifier: "ThemeTableViewCell", for: indexPath) as? ThemeTableCell {
             let theme = Themes.getTheme(indexPath.row)
             themeCell.configureCell(theme: theme)
             return themeCell
         }
         return UITableViewCell()
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 100
     }
 }

 extension ThemeSelctionpopup: UITableViewDelegate {
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: false)
        // let theme = Themes.getTheme(indexPath.row)
       
             Themes.SetTheme(index: indexPath.row)
         
     }
    
    
    
 }


