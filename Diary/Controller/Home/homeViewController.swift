//
//  homeViewController.swift
//  Diary
//
//  Created by Mayuri Shekhar on 13/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit
import Foundation
import SideMenu
class homeViewController: UIViewController {
    @IBOutlet weak var noteTableView: UITableView!
    
    var notes : [Note]?
    let cellSpacingHeight: CGFloat = 50
    private var currentTheme = Themes.currentTheme()
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTableView.register(UINib(nibName: NoteViewCell.nibName, bundle: nil), forCellReuseIdentifier: NoteViewCell.CellReuseIdentifier)
       // self.view.backgroundColor = Current.backgroundColor
        noteTableView.dataSource = self
        noteTableView.delegate = self
        //noteTableView.backgroundColor = Current.backgroundColor
        updateTheme()

        NotificationCenter.default.addObserver(self, selector: #selector(self.updateTheme), name: Notification.Name("Theme"), object: nil)

    }
    
    @objc func updateTheme() {
        currentTheme = Themes.currentTheme()
        self.view.backgroundColor = self.currentTheme.background

    }
    
    override func viewWillAppear(_ animated: Bool) {
       
            self.notes = DMBManger.fetchAllNote()
        DispatchQueue.main.async {
            self.noteTableView.reloadData()
        }
        print(notes!)
        
    }
    
    @IBAction func onClickMenu(_ sender: Any) {
        if let menuVc = self.storyboard?.instantiateViewController(identifier: "MenuViewController") as? MenuViewController {
            let menu = SideMenuNavigationController(rootViewController:menuVc )
            menu.leftSide = true
            menu.navigationBar.isHidden = true
            present(menu, animated: true, completion: nil)

        }
    }
    

}

extension homeViewController : UITableViewDataSource {
    
    func  numberOfSections(in tableView: UITableView) -> Int {
       return notes!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = noteTableView.dequeueReusableCell(withIdentifier: NoteViewCell.CellReuseIdentifier, for: indexPath) as! NoteTableViewCell
        cell.descriptionViewConstaints.constant = 99
        cell.bacgroundImageView.isHidden = false
        cell.desciptionLabel.isHidden = false

        cell.emojiImageView.image = UIImage(named: notes![indexPath.section].emoji!)
  
        if let cellTitle = notes![indexPath.section].title{
            if (cellTitle != DB.notAvailable){
                cell.titleLabel.text = cellTitle } else{
                cell.titleLabel.isHidden = true            }
        }else
        {
            cell.titleLabel.isHidden = true
        }
        
        if let cellDesc = notes![indexPath.section].noteDescription {
            if (cellDesc != DB.notAvailable){
                cell.desciptionLabel.text = cellDesc }
            else{
                 cell.desciptionLabel.isHidden = true
            }
        }else
            {
                cell.desciptionLabel.isHidden = true
            }
        if let cellDate = notes![indexPath.section].savingDate
        {
            cell.dateLabel.text = cellDate
        }
        
        if let cellEmoji = notes![indexPath.section].emoji{
            if (cellEmoji != DB.notAvailable)
            {
                cell.emojiImageView.image = UIImage(named: cellEmoji)
            }
        }
        if let cellImage = notes![indexPath.section].imageAttachment{
                  
            cell.bacgroundImageView.image = UIImage(data: cellImage)
        } else {
            cell.descriptionViewConstaints.constant = 0
            cell.bacgroundImageView.isHidden = true
        }
        
        return cell

    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: cellSpacingHeight))
        
            headerView.backgroundColor = UIColor.clear
        
        return headerView
    
}
    
}

extension homeViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newNoteVC = self.storyboard?.instantiateViewController(withIdentifier: VC.noteDetailVC) as? NewNoteViewController {
            print(indexPath.section)
            newNoteVC.noteobj = notes?[indexPath.section]
     self.navigationController?.pushViewController(newNoteVC, animated: true)
       }
   
    }
}
