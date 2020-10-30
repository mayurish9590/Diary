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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewMenuItems.delegate = self
        self.tableViewMenuItems.dataSource = self
        // Do any additional setup after loading the view.
    }

}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuCell = UITableViewCell(style: .default, reuseIdentifier: "menucell")
        menuCell.backgroundColor = .black
        menuCell.textLabel?.text = arrayMenuItems[indexPath.row]
        menuCell.textLabel?.textColor = UIColor.white
        return menuCell
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
