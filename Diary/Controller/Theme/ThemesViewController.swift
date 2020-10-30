//
//  ThemesViewController.swift
//  Dairy
//
//  Created by Swapnil Waghmare on 29/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Themes"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let buttonback = UIBarButtonItem(image: UIImage(named: "left-arrow"), style: .plain, target: self, action:#selector(onClickBack))
        self.navigationItem.leftBarButtonItem  = buttonback

    }
    
    func setupTheme()  {
       // self.navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    @objc func onClickBack(){
        self.navigationController?.popViewController(animated: true)
    }
}
