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

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var noteTableView: UITableView!
    var btn : UIButton!
    var notes : [NoteModel]?
    let cellSpacingHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTableView.register(UINib(nibName: NoteViewCell.nibName, bundle: nil), forCellReuseIdentifier: NoteViewCell.CellReuseIdentifier)
      
        noteTableView.dataSource = self
        noteTableView.delegate = self
       updateTheme()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateTheme), name: Notification.Name("Theme"), object: nil)
      
        floatingButton()
    }
    
    @objc func updateTheme() {
        var currentTheme = Themes.currentTheme()
        self.backgroundImage.image = currentTheme.background
        navigationController?.navigationBar.barTintColor = currentTheme.navBar
        
    }
    
func floatingButton(){
    let btn = UIButton(type: .custom)
    let x = UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 3.5)
    let y = UIScreen.main.bounds.height -  300
    
    btn.frame = CGRect(x: x, y: y, width: 80, height: 80)
    btn.setTitle("New", for: .normal)
    btn.setTitleColor(Themes.currentTheme().Text, for: .normal)
    btn.backgroundColor = Themes.currentTheme().alert
    btn.clipsToBounds = true
    btn.layer.cornerRadius = 40
    btn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    btn.layer.borderWidth = 3.0
    btn.addTarget(self, action: #selector(self.onclickNew), for: .touchUpInside)
    self.btn = btn
    view.addSubview(btn)
}
    override func viewWillAppear(_ animated: Bool) {
        self.notes = DMBManger.fetchAllNote()
        DispatchQueue.main.async {
            self.noteTableView.reloadData()
        }
        print(notes!)
        
    }
    
   @objc func onclickNew()
    {  if let newNoteVC = self.storyboard?.instantiateViewController(withIdentifier: VC.noteDetailVC) as? NewNoteViewController {
           self.navigationController?.pushViewController(newNoteVC, animated: true)
             }
    }
    
    @IBAction func onClickMenu(_ sender: Any) {
     if let menuVc = self.storyboard?.instantiateViewController(identifier: "MenuViewController") as? MenuViewController {
            let menu = SideMenuNavigationController(rootViewController:menuVc )
            menu.leftSide = true
            menu.navigationBar.isHidden = true
            present(menu, animated: true, completion: nil)
        }
    }
    

    @IBAction func onClickSort(_ sender: Any) {
    
        SortPopup.instance.delegate = self
        SortPopup.instance.showAlert(topSpacingForContainer:self.topbarHeight)
    
    
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
        cell.containerView.backgroundColor = Themes.currentTheme().navBar
        if let note = notes{
        cell.emojiImageView.image = UIImage(named: note[indexPath.section].emoji!)
  
        if let cellTitle = note[indexPath.section].title{
            if (cellTitle != DB.notAvailable){
                cell.titleLabel.text = cellTitle } else{
                cell.titleLabel.isHidden = true            }
        }else
        {
            cell.titleLabel.isHidden = true
        }
        
        if let cellDesc = note[indexPath.section].noteDescription {
            if (cellDesc != DB.notAvailable){
                cell.desciptionLabel.text = cellDesc }
            else{
                 cell.desciptionLabel.isHidden = true
            }
        }else
            {
                cell.desciptionLabel.isHidden = true
            }
        
            let  formatter = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
         
            cell.dateLabel.text = formatter.string(from: note[indexPath.section].savingDate)
            //note[indexPath.section].savingDate.description
      
        
        if let cellEmoji = note[indexPath.section].emoji{
            if (cellEmoji != DB.notAvailable)
            {
                cell.emojiImageView.image = UIImage(named: cellEmoji)
            }
        }
        if let cellImage = note[indexPath.section].imageAttachment{
                  
            cell.bacgroundImageView.image = UIImage(contentsOfFile: cellImage)
        } else {
            cell.descriptionViewConstaints.constant = 0
            cell.bacgroundImageView.isHidden = true
        }
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
func scrollViewDidScroll(_ scrollView: UIScrollView) {

    let x = UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 3.5)
    let y = UIScreen.main.bounds.height - 300
    btn.frame = CGRect(x: x, y: y, width: btn.frame.size.width, height: btn.frame.size.height)
    }
    
    
}

extension homeViewController: SortPopupView{
    func sortByOlderFirst() {
        self.notes = DMBManger.fetchAllNote()
              
              DispatchQueue.main.async {
                         self.noteTableView.reloadData()
                     
              }
                    }
    
    func sortByNewerFirst() {
        let notes = DMBManger.fetchAllNote()
        self.notes = notes?.reversed()
        DispatchQueue.main.async {
                   self.noteTableView.reloadData()
               
        }
               
    }
    
    func sortByAToZ() {
        self.notes = DMBManger.sortbyAToZ()
               DispatchQueue.main.async {
                   self.noteTableView.reloadData()
               }
               print(notes!)
               
    }
    
    func sortByZtoA() {
        self.notes = DMBManger.sortByZtoA()
               DispatchQueue.main.async {
                   self.noteTableView.reloadData()
               }
               print(notes!)
               
    }
    
   
    
    
    
}
