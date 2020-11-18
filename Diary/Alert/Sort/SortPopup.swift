//
//  SortPopup.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 12/11/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit

class SortPopup: UIView {
    
    @IBOutlet weak var containerTopSpacingCnstraint: NSLayoutConstraint!
    @IBOutlet var parentView: SortPopup!
    @IBOutlet weak var newerFirstslected: UIButton!
    
    @IBOutlet weak var newerfirstUnselcted: UIButton!
    
    @IBOutlet weak var containerVIew: UIView!
    @IBOutlet weak var olderFirstSelcted: UIButton!
    @IBOutlet weak var olderFirstUnslected: UIButton!
    
    @IBOutlet weak var atoZselected: UIButton!
    
    @IBOutlet weak var atozUnslected: UIButton!
    
    @IBOutlet weak var ztoAunselected: UIButton!
    
    @IBOutlet weak var ztoaselected: UIButton!
    
    
    
    
    var delegate : SortPopupView!
      static var instance = SortPopup()

     
     
      override init(frame: CGRect) {
         super.init(frame: frame)
          Bundle.main.loadNibNamed(Nib.sortPopup, owner: self, options: nil)
          commonInit()
      }
      required init?(coder: NSCoder) {
          super.init(coder: coder)
          //fatalError("init(coder:) has not been implemented")
      }
      
    
    
    
    private func commonInit() {
           containerVIew.layer.cornerRadius = 10
           containerVIew.layer.borderColor = UIColor.white.cgColor
           containerVIew.layer.borderWidth = 2
        let currentTheme = Themes.currentTheme()
        containerVIew.backgroundColor = currentTheme.alert
           parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
           parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
           
           let tapGesture = UITapGestureRecognizer(target: self,
                            action: #selector(dismissPopoup))
           parentView.addGestureRecognizer(tapGesture)

       
        newerFirstslected.isHidden = true
        olderFirstSelcted.isHidden = true
        atoZselected.isHidden = true
        ztoaselected.isHidden = true
        
    }
       
       func showAlert(topSpacingForContainer: CGFloat) {
           if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
               containerTopSpacingCnstraint.constant = topSpacingForContainer
               window.addSubview(parentView)
               
           }
       }
     
    @objc func dismissPopoup() {
           parentView.endEditing(true)
           parentView.removeFromSuperview()
       }
    
    
    
    
    @IBAction func onClickNewerFirst(_ sender: Any) {
    
        self.newerFirstslected.isHidden = false
        self.newerfirstUnselcted.isHidden = true
        dismissPopoup()
        self.newerFirstslected.isHidden = true
        self.newerfirstUnselcted.isHidden = false
        if let tampDelegate = self.delegate{
            tampDelegate.sortByNewerFirst()
            
        }
    }
    
    @IBAction func onClickOlderFirst(_ sender: Any) {
     self.olderFirstUnslected.isHidden = false
    self.olderFirstSelcted.isHidden = true
           dismissPopoup()
    
    self.olderFirstSelcted.isHidden = true
    self.olderFirstUnslected.isHidden = false
    if let tampDelegate = self.delegate{ tampDelegate.sortByOlderFirst()
                            
                        }
                 
            
    }
    
    @IBAction func onClickAtoZ(_ sender: Any) {
    
        self.atoZselected.isHidden = false
        self.atozUnslected.isHidden = true
               dismissPopoup()
               self.atoZselected.isHidden = true
               self.atozUnslected.isHidden = false
             
        if let tampDelegate = self.delegate{
                   tampDelegate.sortByAToZ()
                   
               }
        
        
        
        
        
        
    }
    
    @IBAction func onclickZtoA(_ sender: Any) {
    self.ztoaselected.isHidden = false
    self.ztoAunselected.isHidden = true
    dismissPopoup()
      
        self.ztoaselected.isHidden = true
        self.ztoAunselected.isHidden = false
                   if let tampDelegate = self.delegate{
        tampDelegate.sortByZtoA()
        
    }
    }
    
    
}
