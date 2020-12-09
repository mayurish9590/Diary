//
//  TextViewContainer.swift
//  Diary
//
//  Created by Swapnil Waghmare on 09/12/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import Foundation
import UIKit

class ImageViewPoppup: UIView {
    
    
    @IBOutlet weak var buttonDismiss: UIButton!
    static var instance = ImageViewPoppup()
    @IBOutlet weak var shadowView: UIView!
    
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var containerVIew: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed(Nib.imageViewPopup, owner: self, options: nil)
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
        
        self.imageView.backgroundColor = Themes.currentTheme().navBar
        self.containerVIew.backgroundColor = Themes.currentTheme().navBar

        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(dismissPopoup))
        shadowView.addGestureRecognizer(tapGesture)
    }
    
    func showAlert(image: UIImage) {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            self.imageView.image = image
            window.addSubview(parentView)

        }
    }
    
    @objc func dismissPopoup() {
        
        parentView.endEditing(true)
        parentView.removeFromSuperview()
    }

    
    @IBAction func onClickDismissPopup(_ sender: Any) {
        self.dismissPopoup()
    }
}

