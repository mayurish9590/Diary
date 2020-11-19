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
       
    func updateTheme()
    {
        let currentTheme = Themes.currentTheme()
        self.newerFirstslected.backgroundColor = currentTheme.foreground
        self.newerfirstUnselcted.backgroundColor = currentTheme.foreground
        self.olderFirstUnslected.backgroundColor = currentTheme.foreground
        self.olderFirstSelcted.backgroundColor = currentTheme.foreground
         self.ztoaselected.backgroundColor = currentTheme.foreground
        self.ztoAunselected.backgroundColor = currentTheme.foreground
        self.atoZselected.backgroundColor = currentTheme.foreground
        self.atozUnslected.backgroundColor = currentTheme.foreground
        
        self.newerFirstslected.setTitleColor(currentTheme.Text, for: .normal)
        self.newerfirstUnselcted.setTitleColor(currentTheme.Text, for: .normal)
        self.olderFirstUnslected.setTitleColor(currentTheme.Text, for: .normal)
        self.olderFirstSelcted.setTitleColor(currentTheme.Text, for: .normal)
         self.ztoaselected.setTitleColor(currentTheme.Text, for: .normal)
        self.ztoAunselected.setTitleColor(currentTheme.Text, for: .normal)
        self.atoZselected.setTitleColor(currentTheme.Text, for: .normal)
        self.atozUnslected.setTitleColor(currentTheme.Text, for: .normal)
        
        
    }
    
       func showAlert(topSpacingForContainer: CGFloat) {
           if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
               containerTopSpacingCnstraint.constant = topSpacingForContainer
               window.addSubview(parentView)
               updateTheme()
           }
       }
     
    @objc func dismissPopoup() {
           parentView.endEditing(true)
           parentView.removeFromSuperview()
       }
    
    
    
    
    @IBAction func onClickNewerFirst(_ sender: Any) {
    
        self.newerFirstslected.isHidden = false
        self.newerfirstUnselcted.isHidden = true
        self.olderFirstUnslected.isHidden = false
        self.olderFirstSelcted.isHidden = true
         self.ztoaselected.isHidden = true
        self.ztoAunselected.isHidden = false
        self.atoZselected.isHidden = true
        self.atozUnslected.isHidden = false
        dismissPopoup()
       
        if let tampDelegate = self.delegate{
            tampDelegate.sortByNewerFirst()
            
        }
    }
    
    @IBAction func onClickOlderFirst(_ sender: Any) {
    self.olderFirstUnslected.isHidden = true
    self.olderFirstSelcted.isHidden = false
    self.newerFirstslected.isHidden = true
    self.newerfirstUnselcted.isHidden = false
    self.ztoaselected.isHidden = true
    self.ztoAunselected.isHidden = false
        self.atoZselected.isHidden = true
        self.atozUnslected.isHidden = false
        
           dismissPopoup()
    
   
    if let tampDelegate = self.delegate{ tampDelegate.sortByOlderFirst()
                            
                        }
                 
            
    }
    
    @IBAction func onClickAtoZ(_ sender: Any) {
    self.newerFirstslected.isHidden = true
    self.newerfirstUnselcted.isHidden = false
        self.atoZselected.isHidden = false
        self.atozUnslected.isHidden = true
         self.olderFirstSelcted.isHidden = true
           self.olderFirstUnslected.isHidden = false
         self.ztoaselected.isHidden = true
               self.ztoAunselected.isHidden = false
        dismissPopoup()
               
             
        if let tampDelegate = self.delegate{
                   tampDelegate.sortByAToZ()
                   
               }
        
        
        
        
        
        
    }
    
    @IBAction func onclickZtoA(_ sender: Any) {
        self.newerFirstslected.isHidden = true
        self.newerfirstUnselcted.isHidden = false
    self.ztoaselected.isHidden = false
    self.ztoAunselected.isHidden = true
    self.olderFirstSelcted.isHidden = true
    self.olderFirstUnslected.isHidden = false
    self.atoZselected.isHidden = true
    self.atozUnslected.isHidden = false
        
    dismissPopoup()
      
       
                   if let tampDelegate = self.delegate{
        tampDelegate.sortByZtoA()
        
    }
    }
    
    
}
