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
    @IBOutlet weak var buttonNewerFirst: UIButton!
    
    @IBOutlet weak var containerVIew: UIView!
    
    @IBOutlet weak var buttonOlderFirst: UIButton!
    @IBOutlet weak var buttonAtoZ: UIButton!
    
    @IBOutlet weak var buttonZtoA: UIButton!
    
    
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
    }
    
    func updateTheme()
    {
        if let selectedIndex = UserDefaults.standard.value(forKey: "sortselectionindex") as? Int{
            self.updateSwitchState(buttonTag: selectedIndex)
        } else {
            self.updateSwitchState(buttonTag: 0);
        }
        let currentTheme = Themes.currentTheme()
        self.buttonNewerFirst.backgroundColor = currentTheme.foreground
        self.buttonOlderFirst.backgroundColor = currentTheme.foreground
        self.buttonZtoA.backgroundColor = currentTheme.foreground
        self.buttonAtoZ.backgroundColor = currentTheme.foreground
        
        self.buttonNewerFirst.setTitleColor(currentTheme.Text, for: .normal)
        self.buttonOlderFirst.setTitleColor(currentTheme.Text, for: .normal)
        self.buttonAtoZ.setTitleColor(currentTheme.Text, for: .normal)
        self.buttonZtoA.setTitleColor(currentTheme.Text, for: .normal)

        
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

    @IBAction func onClickNewerFirst(_ sender: UIButton) {
        updateSwitchState(buttonTag: sender.tag)

        dismissPopoup()
        UserDefaults.standard.setValue(0, forKey: "sortselectionindex")
        if let tampDelegate = self.delegate{
            tampDelegate.sortByNewerFirst()
            
        }
    }
    
    @IBAction func onClickOlderFirst(_ sender: UIButton) {
        updateSwitchState(buttonTag: sender.tag)

        dismissPopoup()
        UserDefaults.standard.setValue(1, forKey: "sortselectionindex")
        
        if let tampDelegate = self.delegate{ tampDelegate.sortByOlderFirst()
            
        }
        
        
    }
    
    @IBAction func onClickAtoZ(_ sender: UIButton) {
        updateSwitchState(buttonTag: sender.tag)

        dismissPopoup()
        UserDefaults.standard.setValue(2, forKey: "sortselectionindex")
        
        if let tampDelegate = self.delegate{
            tampDelegate.sortByAToZ()
            
        }
    }
    
    @IBAction func onclickZtoA(_ sender: UIButton) {
        updateSwitchState(buttonTag: sender.tag)
        dismissPopoup()
        UserDefaults.standard.setValue(3, forKey: "sortselectionindex")
        
        if let tampDelegate = self.delegate{
            tampDelegate.sortByZtoA()
            
        }
    }
    func updateSwitchState(buttonTag: Int) {
        let selectedImageName = "circle.fill"
        let unselectedImageName = "circle"
        switch buttonTag {
        case 0:
            self.buttonNewerFirst.setImage(UIImage.init(systemName: selectedImageName), for: .normal)
            self.buttonOlderFirst.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
            self.buttonAtoZ.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
            self.buttonZtoA.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
        case 1:
            self.buttonNewerFirst.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
            self.buttonOlderFirst.setImage(UIImage.init(systemName: selectedImageName), for: .normal)
            self.buttonAtoZ.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
            self.buttonZtoA.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
        case 2:
            self.buttonNewerFirst.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
            self.buttonOlderFirst.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
            self.buttonAtoZ.setImage(UIImage.init(systemName: selectedImageName), for: .normal)
            self.buttonZtoA.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
        case 3:
            self.buttonNewerFirst.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
            self.buttonOlderFirst.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
            self.buttonAtoZ.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
            self.buttonZtoA.setImage(UIImage.init(systemName: selectedImageName), for: .normal)
        default:
            self.buttonNewerFirst.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
            self.buttonOlderFirst.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
            self.buttonAtoZ.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
            self.buttonZtoA.setImage(UIImage.init(systemName: unselectedImageName), for: .normal)
        }
    }

}

