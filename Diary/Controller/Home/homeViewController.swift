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
    var btn : UIButton!
    var notes : [NoteModel] = []
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
        let currentTheme = Themes.currentTheme()
        navigationController?.navigationBar.barTintColor = currentTheme.navBar
        
    }
    
    func floatingButton(){
        let btn = UIButton(type: .custom)
        let x = 0.75 * UIScreen.main.bounds.width
        let y = 0.75 * UIScreen.main.bounds.height
        
        btn.frame = CGRect(x: x, y: y, width: 60, height: 60)
        //btn.setTitle("New", for: .normal)
        
        btn.setImage(UIImage.init(systemName: "square.and.pencil"), for: .normal)
        btn.setTitleColor(Themes.currentTheme().Text, for: .normal)
        btn.tintColor  = UIColor.white
        btn.backgroundColor = Themes.currentTheme().alert
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 30
        btn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: #selector(self.onclickNew), for: .touchUpInside)
        self.btn = btn
        self.view.addSubview(btn)
        self.view.bringSubviewToFront(btn)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.notes = DMBManger.fetchAllNote() ?? []
        DispatchQueue.main.async {
            self.noteTableView.reloadData()
        }
        print(notes)
        
    }
    
    @objc func onclickNew()
    {  if let newNoteVC = self.storyboard?.instantiateViewController(withIdentifier: VC.noteDetailVC) as? NewNoteViewController {
        self.navigationController?.pushViewController(newNoteVC, animated: true)
    }
    }
    
    @IBAction func onClickMenu(_ sender: Any) {
        /*
         if let menuVc = self.storyboard?.instantiateViewController(identifier: "MenuViewController") as? MenuViewController {
         let menu = SideMenuNavigationController(rootViewController:menuVc )
         menu.leftSide = true
         menu.navigationBar.isHidden = true
         present(menu, animated: true, completion: nil)
         }
         */
    }
    
    
    @IBAction func onClickSort(_ sender: Any) {
        
        SortPopup.instance.delegate = self
        SortPopup.instance.showAlert(topSpacingForContainer:self.topbarHeight)
    }
}

extension homeViewController : UITableViewDataSource {
    
    func  numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = noteTableView.dequeueReusableCell(withIdentifier: NoteViewCell.CellReuseIdentifier, for: indexPath) as? NoteTableViewCell{
            if self.notes.count > indexPath.row {
                let note = self.notes[indexPath.row]
                cell.configureCell(note: note)
            }
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.notes.count > indexPath.row {
            if self.notes[indexPath.row].imageAttachment {
                return 240
            } else {
                return 145
            }
            
        } else {
            return 0
        }
        
    }
    
}

extension homeViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newNoteVC = self.storyboard?.instantiateViewController(withIdentifier: VC.noteDetailVC) as? NewNoteViewController {
            print(indexPath.section)
            newNoteVC.noteobj = self.notes[indexPath.row]
            self.navigationController?.pushViewController(newNoteVC, animated: true)
        }
        
    }
    
}

extension homeViewController: SortPopupView{
    func sortByOlderFirst() {
        self.notes = DMBManger.fetchAllNote() ?? []
        
        DispatchQueue.main.async {
            self.noteTableView.reloadData()
            
        }
    }
    
    func sortByNewerFirst() {
        self.notes = self.notes.reversed()
        DispatchQueue.main.async {
            self.noteTableView.reloadData()
            
        }
        
    }
    
    func sortByAToZ() {
        /*
         self.notes = DMBManger.sortbyAToZ() ?? []
         DispatchQueue.main.async {
         self.noteTableView.reloadData()
         }
         */
    }
    
    func sortByZtoA() {
        /*
         self.notes = DMBManger.sortByZtoA() ?? []
         DispatchQueue.main.async {
         self.noteTableView.reloadData()
         }
         */
    }
    
}
