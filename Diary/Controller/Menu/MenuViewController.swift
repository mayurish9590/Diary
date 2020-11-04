//
//  MenuViewController.swift
//  Dairy
//
//  Created by Swapnil Waghmare on 29/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableViewMenuItems: UITableView!
    private var arrayMenuItems = ["Theme styles", "Font", "Reminder","Language"]
    private var currentTheme = Themes.currentTheme()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateTheme()

        NotificationCenter.default.addObserver(self, selector: #selector(self.updateTheme), name: Notification.Name("Theme"), object: nil)
        self.tableViewMenuItems.delegate = self
        self.tableViewMenuItems.dataSource = self

    }
    @objc func updateTheme() {
        currentTheme = Themes.currentTheme()
        self.view.backgroundColor = self.currentTheme.foreground
        tableViewMenuItems.reloadData()
    }

}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuCell = UITableViewCell(style: .default, reuseIdentifier: "menucell")
        menuCell.backgroundColor = self.currentTheme.foreground
        menuCell.textLabel?.text = arrayMenuItems[indexPath.row]
        menuCell.textLabel?.textColor = self.currentTheme.Text
        return menuCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            if let vc = self.storyboard?.instantiateViewController(identifier: "ThemesViewController") as? ThemesViewController {
                self.navigationController?.pushViewController(vc, animated: true);
            }
        }
    }
}
