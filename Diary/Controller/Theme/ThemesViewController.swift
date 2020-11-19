//
//  ThemesViewController.swift
//  Dairy
//
//  Created by Swapnil Waghmare on 29/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
  
    
    @IBOutlet weak var backgroundImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Themes"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let buttonback = UIBarButtonItem(image: UIImage(named: "left-arrow"), style: .plain, target: self, action:#selector(onClickBack))
        self.navigationItem.leftBarButtonItem  = buttonback
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.updateTheme()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateTheme), name: Notification.Name("Theme"), object: nil)

    }

    @objc func updateTheme() {
        let currentTheme = Themes.currentTheme()
        self.backgroundImage.image = currentTheme.background

    }
    
    
    @objc func onClickBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ThemesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Themes.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let themeCell = tableView.dequeueReusableCell(withIdentifier: "ThemeTableViewCell", for: indexPath) as? ThemeTableViewCell {
            let theme = Themes.getTheme(indexPath.row)
            themeCell.configureCell(theme: theme)
            return themeCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ThemesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let theme = Themes.getTheme(indexPath.row)
        if !theme.isLocked {
            Themes.SetTheme(index: indexPath.row)
        }
    }
}
