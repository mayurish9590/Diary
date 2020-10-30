//
//  MoreMenuPopup.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 26/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit

class MoreMenuPopup: UIView {
   
    @IBOutlet weak var topCOnstraintForContainer: NSLayoutConstraint!
    
    @IBOutlet var parentView: UIView!
    static var instance = MoreMenuPopup()
     var delegate : MoreMenu?
    
    @IBOutlet weak var containerViewForButtons: UIView!
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        Bundle.main.loadNibNamed(Nib.moreMenuPopup, owner: self, options: nil)
        commonInit()
    }
    
    private func commonInit() {
        containerViewForButtons.layer.cornerRadius = 10
        containerViewForButtons.layer.borderColor = UIColor.white.cgColor
        containerViewForButtons.layer.borderWidth = 2
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(dismissPopoup))
        parentView.addGestureRecognizer(tapGesture)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissPopoup() {
        parentView.endEditing(true)
        parentView.removeFromSuperview()
    }
    
    @IBAction func onClickDelete(_ sender: Any) {
        dismissPopoup()
        if let _delegate = self.delegate{
            _delegate.deleteNote()
        }
    }
    
    @IBAction func onClickShare(_ sender: Any) {
        dismissPopoup()
        if let _delegate = self.delegate{
            _delegate.shareNote()
        }
    }
    
    func showAlert(topSpacingForContainer: CGFloat) {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            topCOnstraintForContainer.constant = topSpacingForContainer
            window.addSubview(parentView)
            
        }
    }
/*
static func getView() -> UIView!
        {
            if let nib = Bundle.main.loadNibNamed(Nib.moreMenuPopup, owner:  MoreMenuPopup(), options: nil),
                       let nibView = nib.first as? UIView{
                       nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                nibView.frame =  CGRect(x:UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 8.5, width: UIScreen.main.bounds.width / 2.8 , height: UIScreen.main.bounds.height / 5)
                return nibView    }
            return nil
        }
    */
    }
    
    

