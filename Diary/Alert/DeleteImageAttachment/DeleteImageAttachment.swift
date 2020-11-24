//
//  DeleteImageAttachment.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 30/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit

class DeleteImageAttachment: UIView {

    static var instance = DeleteImageAttachment()
      var delegate : DeleteImagePopUp?
   
    @IBOutlet var parentView: DeleteImageAttachment!
    @IBOutlet weak var containerView: UIView!
    
 
      
      override init(frame: CGRect) {
         super.init(frame: frame)
        Bundle.main.loadNibNamed(Nib.deleteImagePopup, owner: self, options: nil)
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
      
      func showAlert() {
          if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
              window.addSubview(parentView)
            updateTheme()
          }
      }
    func updateTheme()
    {
         containerView.backgroundColor = Themes.currentTheme().alert
    }
    
      
      @objc func dismissPopoup() {
          parentView.endEditing(true)
          parentView.removeFromSuperview()
      }

   
    @IBAction func onlickCancel(_ sender: Any) {
    dismissPopoup()
    }
    
  
    
    
    @IBAction func onClickDelete(_ sender: Any) {
        dismissPopoup()
         if let _delegate = self.delegate{
          _delegate.deleteImage()
        }
    }
    
   
        
    }
    

