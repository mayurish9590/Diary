//
//  TextViewContainer.swift
//  Diary
//
//  Created by Swapnil Waghmare on 09/12/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import Foundation
import UIKit

class TextViewPoppup: UIView {
    
    
    var delegate : TextViewProtocol!
    static var instance = TextViewPoppup()
   
    
    @IBOutlet weak var buttonDismiss: UIButton!
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var containerVIew: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed(Nib.textViewPopup, owner: self, options: nil)
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
        buttonDismiss.layer.cornerRadius = 10
        buttonDismiss.layer.borderColor = UIColor.white.cgColor
        buttonDismiss.layer.borderWidth = 1
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.textView.backgroundColor = Themes.currentTheme().navBar
        self.containerVIew.backgroundColor = Themes.currentTheme().navBar

        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(dismissPopoup))
        shadowView.addGestureRecognizer(tapGesture)
        self.textView.delegate = self
    }
    
    func showAlert(text: String) {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            self.textView.text = text
            window.addSubview(parentView)
            self.textView.selectedRange = NSMakeRange(self.textView.text.count , 0);
            self.textView.becomeFirstResponder()

        }
    }
    
    @objc func dismissPopoup() {
        
        if let delegate = self.delegate{
            delegate.textViewPopupDismissed(text: self.textView.text)
        }

        parentView.endEditing(true)
        parentView.removeFromSuperview()
    }

    
    @IBAction func onClickDismiss(_ sender: Any) {
        self.dismissPopoup()
    }
}

extension TextViewPoppup: UITextViewDelegate {
    
}
