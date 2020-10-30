//
//  NoteViewController.swift
//  Diary
//
//  Created by Mayuri Shekhar on 25/09/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource {
    
 
    @IBOutlet weak var noteTableView: UITableView!
    var isSideMenueHidden : Bool = true
    
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        HomeViewController.dataSource = self
        HomeViewController.delegate = self
        HomeViewController.register(UINib(nibName: NoteViewCell.nibName, bundle: nil), forCellReuseIdentifier: NoteViewCell.CellReuseIdentifier)
        self.view.backgroundColor = Theme.darkTheme
        
        
    }
    

    @IBAction func onClickMenuButton(_ sender: Any) {
   
      
    
   
    }
}

extension HomeViewController : UITableViewDelegate{
    
}

extension HomeViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteViewCell.CellReuseIdentifier, for: indexPath) as! NoteTableViewCell
        cell.emojiImageView.image = UIImage(named: "FunnyEmoji")
       // cell.bacgroundImageView.image = UIImage(named: "bg1")
      
        
        
        
       
        return cell
    }
    
    
}

