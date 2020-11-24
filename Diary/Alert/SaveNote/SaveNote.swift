//
//  saveNote.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 22/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit
import Foundation
class SaveNote: UIView {

    static var instance = SaveNote()
    var delegate : SaveNotePopUp?
    
    @IBOutlet var parentView: SaveNote!
    @IBOutlet weak var containerView: UIView!
    

    
    @IBOutlet weak var saveButton: UIButton!
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        Bundle.main.loadNibNamed(Nib.saveNoteAlert, owner: self, options: nil)
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
    
    func showAlert() {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            window.addSubview(parentView)
            updateTheme()
        }
    }
    
    @objc func dismissPopoup() {
        parentView.endEditing(true)
        parentView.removeFromSuperview()
    }
  /*
    static func getAlertView() -> UIView?
    {
        if let nib = Bundle.main.loadNibNamed(Nib.saveNoteAlert, owner: saveNote(), options: nil),
               let nibView = nib.first as? UIView{
               nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            nibView.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
            nibView.backgroundColor = Current.backgroundColor
            return nibView
        }
     return nil
    }
    */
    
    
    @IBAction func onClickSave(_ sender: Any) {
        dismissPopoup()
        if let _delegate = self.delegate{
              _delegate.save()
        }
    }
    @IBAction func onClickDiscard(_ sender: Any) {
        dismissPopoup()
        if let _delegate = self.delegate{
              _delegate.discardChange()
              }
    }
    
   
}
