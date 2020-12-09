//
//  AddNote.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 07/12/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit

class AddNote: UIView {
    @IBOutlet var parentView: AddNote!
    
    static var instance = AddNote()
     var calnderDate : Date!
    @IBOutlet weak var containerView: UIView!
    var delegate: AddNoteProtocol?
   override init(frame: CGRect) {
         super.init(frame: frame)
          Bundle.main.loadNibNamed("AddNote", owner: self, options: nil)
          commonInit()
      }
      required init?(coder: NSCoder) {
          super.init(coder: coder)
          //fatalError("init(coder:) has not been implemented")
      }
      
      private func commonInit() {
          containerView.layer.cornerRadius = 10
          containerView.layer.borderColor = UIColor.white.cgColor
          containerView.layer.borderWidth = 2
        
          parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
          parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
          
          let tapGesture = UITapGestureRecognizer(target: self,
                           action: #selector(dismissPopoup))
          parentView.addGestureRecognizer(tapGesture)

      }
      func updateTheme()
      {
             let currenttheme = Themes.currentTheme()
                      containerView.backgroundColor = currenttheme.alert
      }
      
    func showAlert(calnderDt : Date) {
          if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
              window.addSubview(parentView)
              updateTheme()
            calnderDate = calnderDt
            
        }
      }
      
      @objc func dismissPopoup() {
          parentView.endEditing(true)
          parentView.removeFromSuperview()
      }
  
    @IBAction func onClickCancel(_ sender: Any) {
    dismissPopoup()
        
    }
    
    @IBAction func onClickAdd(_ sender: Any) {
        
        if let del = self.delegate {
            del.add(date: self.calnderDate )
        }

        dismissPopoup()
        //NewNoteViewController.dateFromCalender = nil
    }
    
      
}
