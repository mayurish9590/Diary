//
//  ImageAttachmentPopup.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 23/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit


class ImageAttachmentPopup: UIView {
    
    @IBOutlet weak var containerVIew: UIView!
    
    @IBOutlet weak var containerTopSpacingCnstraint: NSLayoutConstraint!
    @IBOutlet var parentView: ImageAttachmentPopup!
     var delegate : ImageAttachemet?
    static var instance = ImageAttachmentPopup()

   
   
    override init(frame: CGRect) {
       super.init(frame: frame)
        Bundle.main.loadNibNamed(Nib.imageAttachmentPopup, owner: self, options: nil)
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
    
    @IBAction func onClickPhoto(_ sender: Any) {
        dismissPopoup()
        if let _delegate = self.delegate
        {
            _delegate.addFromPhotos()
        }
    }
    
    
    @IBAction func onClickCamera(_ sender: Any) {
        dismissPopoup()
    if let _delegate = self.delegate
    {
        _delegate.addFromCamera()
    }
    }
    
    /*
    static func getView() -> UIView!
    {
        if let nib = Bundle.main.loadNibNamed(Nib.imageAttachmentPopup, owner: ImageAttachmentPopup(), options: nil),
                      let nibView = nib.first as? UIView{
                      nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            nibView.frame =  CGRect(x:(UIScreen.main.bounds.width - 200 ), y: 100 , width: UIScreen.main.bounds.width / 2.5, height: UIScreen.main.bounds.height / 6)
                  // nibView.backgroundColor = Current.backgroundColor
           
                   return nibView
               }
        
            return nil    }
 */
    
}
