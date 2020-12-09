//
//  CalenderViewController.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 10/11/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit
import KDCalendar
import EventKit
import Foundation


class CalenderViewController: UIViewController {
    let  formatter = DateFormatter()
    
    @IBOutlet weak var calenderView: CalendarView!
    var notesarraytableview :[NoteModel] =  []
    var notesArrayDB :[NoteModel] =  []
    var startDay: Date!
    @IBOutlet weak var notesTableView: UITableView!
    
    override func viewDidLoad() {
        navigationBarSetup()
        self.notesArrayDB = DMBManger.fetchAllNote() ?? []
        setUpCalendar()
        self.notesTableView.register(UINib(nibName: NoteViewCell.nibName, bundle: nil), forCellReuseIdentifier: NoteViewCell.CellReuseIdentifier)
     
        let sortedNotes = self.notesArrayDB.filter { dates in
            formatter.string(from: dates.savingDate) == formatter.string(from: self.calenderView.displayDate ?? Date())
        }
        self.notesarraytableview = sortedNotes
        notesTableView.delegate = self
        notesTableView.dataSource = self
        self.notesTableView.reloadData()
    }
    
    
    func setUpCalendar()
    {
        calenderView.delegate = self
        calenderView.dataSource = self
        
        formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
        
        let style = CalendarView.Style()
        self.view.backgroundColor = Themes.currentTheme().background
        self.navigationItem.backBarButtonItem?.title = "Back"
        style.cellShape                = .bevel(8.0)
        style.cellColorDefault         = UIColor.clear
        style.cellColorToday           = Themes.currentTheme().alert
        style.cellSelectedBorderColor  = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
        style.cellEventColor           = Themes.currentTheme().navBar
        style.headerTextColor          = Themes.currentTheme().Text
        style.cellTextColorDefault     = Themes.currentTheme().foreground
        style.cellTextColorToday       = Themes.currentTheme().Text
        style.cellTextColorWeekend     = UIColor(red: 237/255, green: 103/255, blue: 73/255, alpha: 1.0)
        style.cellColorOutOfRange      = UIColor(red: 249/255, green: 226/255, blue: 212/255, alpha: 1.0)
        style.weekdaysTextColor = Themes.currentTheme().Text
        style.headerBackgroundColor    = Themes.currentTheme().navBar
        style.weekdaysBackgroundColor  = Themes.currentTheme().alert
        style.firstWeekday     = .sunday
        
        style.locale = Locale(identifier: "en_US")
        
        style.cellFont = UIFont(name: "Helvetica", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)
        style.headerFont = UIFont(name: "Helvetica", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)
        style.weekdaysFont = UIFont(name: "Helvetica", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
        
        calenderView.style = style
        calenderView.direction = .horizontal
        calenderView.multipleSelectionEnable = false
        calenderView.marksWeekends = true
        calenderView.selectDate(Date())
        let today = Date()
        
        var tomorrowComponents = DateComponents()
        tomorrowComponents.day = 1
        
        // self.calenderView.calendar.date(byAdding: tomorrowComponents, to: today)
        self.calenderView.setDisplayDate(today)
        calenderView.backgroundColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1.0)
        for note in notesArrayDB {
            self.calenderView.addEvent(String(note.noteID), date: note.savingDate)
        }
    }
    func navigationBarSetup() {
        self.navigationItem.title = "Calendar"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let buttonback = UIBarButtonItem(image: UIImage(named: "left-arrow"), style: .plain, target: self, action:#selector(onClickBack))
        self.navigationItem.leftBarButtonItem  = buttonback
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    
    
    @objc func onClickBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    /*
     @IBAction func onClickPrveousMonth(_ sender: Any) {
     self.calenderView.goToPreviousMonth()
     
     
     for note in notesArrayDB {
     self.calenderView.selectDate(note.savingDate)
     
     }
     
     }
     
     @IBAction func onClickNextMonth(_ sender: Any) {
     self.calenderView.goToNextMonth()
     
     
     }
     */
}

extension CalenderViewController: CalendarViewDataSource{
    func startDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = -1
        let today = Date()
        let threeMonthsAgo = self.calenderView.calendar.date(byAdding: dateComponents, to: today)!
        return threeMonthsAgo
        
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = 12
        let today = Date()
        let twoYearsFromNow = self.calenderView.calendar.date(byAdding: dateComponents, to: today)!
        return twoYearsFromNow
    }
    
    func headerString(_ date: Date) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL yyyy"
        let nameOfMonth = dateFormatter.string(from: date)
        return nameOfMonth
        
    }
    
    
}


extension CalenderViewController: CalendarViewDelegate{
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        for event in events {
            print("\t\"\(event.title)\" - Starting at:\(event.startDate)")
        }
        let sortedNotes = self.notesArrayDB.filter { dates in
            formatter.string(from: dates.savingDate) == formatter.string(from: date)
        }
        self.notesarraytableview = sortedNotes
        self.notesTableView.reloadData()
        
    }
    
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        return true
    }
    
    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
        self.notesarraytableview = []
    }
    
    func calendar(_ calendar: CalendarView, didLongPressDate date: Date, withEvents events: [CalendarEvent]?) {
        AddNote.instance.showAlert(self,date)
    }
}

extension CalenderViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newNoteVC = self.storyboard?.instantiateViewController(withIdentifier: VC.noteDetailVC) as? NewNoteViewController {
            print(indexPath.section)
            newNoteVC.noteobj = self.notesarraytableview[indexPath.row]
            self.navigationController?.pushViewController(newNoteVC, animated: true)
        }
        
    }
    
}
extension CalenderViewController:UITableViewDataSource{
    func  numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notesarraytableview.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = notesTableView.dequeueReusableCell(withIdentifier: NoteViewCell.CellReuseIdentifier, for: indexPath) as? NoteTableViewCell{
            if self.notesarraytableview.count > indexPath.row {
                let note = self.notesarraytableview[indexPath.row]
                cell.configureCell(note: note)
            }
            return cell
        }
        
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.notesarraytableview.count > indexPath.row {
            if self.notesarraytableview[indexPath.row].imageAttachment {
                return 240
            } else {
                return 145
            }
            
        } else {
            return 0
        }
    }
}




