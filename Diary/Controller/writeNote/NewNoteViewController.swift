//
//  NewNoteViewController.swift
//  Diary
//
//  Created by Mayuri Shekhar on 13/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class NewNoteViewController: UIViewController, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var moreMenuButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var addEmojiButton: UIButton!
    
    @IBOutlet weak var attachedImage: UIImageView!
    
    @IBOutlet weak var addImageButton: UIBarButtonItem!
    
    @IBOutlet weak var decriptionViewTrailing: NSLayoutConstraint!
  
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!

    var noteobj: NoteModel?
    let imagePicker = UIImagePickerController()
    var attachimageData : Data!
    var emojiName : String!
  let  formatter = DateFormatter()
                        
    @IBOutlet weak var deleteImageButton: UIButton!
    private var currentTheme = Themes.currentTheme()

    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.attributedPlaceholder =
        NSAttributedString(string: "Title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        initialSetup()
        updateTheme()

        NotificationCenter.default.addObserver(self, selector: #selector(self.updateTheme), name: Notification.Name("Theme"), object: nil)

    }
    @objc func updateTheme() {
         currentTheme = Themes.currentTheme()
        self.backgroundImage.image = currentTheme.background
        self.descriptionView.backgroundColor = currentTheme.alert
    
        
    }
    func initialSetup()
    {
        formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
       if let note = self.noteobj{
            if let _title = note.title {
                if (_title != DB.notAvailable){
                    titleText.text = _title } }
           
            if let _description = note.noteDescription {
                if (_description != DB.notAvailable) {
                    descriptionTextView.text = _description } }
            
        dateLabel.text = formatter.string(from: note.savingDate)
            
            if let _timeLabel = note.savingTime{
                timeLabel.text = _timeLabel
            }
            
            if let _attchimageData = note.imageAttachment {
                self.attachedImage.image = UIImage(contentsOfFile: _attchimageData)
            }
            
            if let _emojiName = note.emoji {
                if( _emojiName != DB.notAvailable){
                 self.emojiName = _emojiName
                    self.addEmojiButton.imageView?.image = UIImage(named: _emojiName)
                }
            }
        }
        else
       {
         dateLabel.text = formatter.string(from: getCurrentDate())
           timeLabel.text = getCurrentTime()
                           }
        
        if(attachedImage.image == nil)
        {
            decriptionViewTrailing.constant = 10
            self.deleteImageButton.isHidden = true
        }
 }
    @IBAction func onClickHomeButton(_ sender: Any) {
        SaveNote.instance.delegate = self
        SaveNote.instance.showAlert()
}
    
    @IBAction func onClickAddEmoji(_ sender: Any) {
        EmojiPopup.instance.delegate = self
        EmojiPopup.instance.showAlert()
    }
 @IBAction func onClickAddPhoto(_ sender: Any) {
        ImageAttachmentPopup.instance.delegate = self
        ImageAttachmentPopup.instance.showAlert(topSpacingForContainer: self.topbarHeight)
        self.deleteImageButton.isHidden = false
    }
 @IBAction func onClickMoreMenu(_ sender: Any) {
        MoreMenuPopup.instance.delegate = self
        MoreMenuPopup.instance.showAlert(topSpacingForContainer: self.topbarHeight)
    }
    
    @IBAction func onClickDeleteImage(_ sender: Any) {
        DeleteImageAttachment.instance.delegate = self
        DeleteImageAttachment.instance.showAlert()
    }
    
    
    func  getCurrentDate() -> Date{
        let currDate = Date()
        return(currDate)
    }
    
    
    func getCurrentTime() -> String {
        let timeformatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm"
            return formatter }()
        let currTime = timeformatter.string(from: Date())
        return(currTime)
        
    }
}
extension NewNoteViewController : SaveNotePopUp {
    func discardChange() {
 self.navigationController?.popViewController(animated: true)
        
    }

    func save() {
        if(self.noteobj != nil )
        {
            //DMBManger.delete(note: self.noteobj!)
            DMBManger.saveToDB(note: self.noteobj!)
            
        } else{
        Current.lastNoteID = Current.lastNoteID + 1
            let _noteDescription: String
            let _title: String
            let imageURL: String
            let emojiName: String
            if self.descriptionTextView.text != nil{
                _noteDescription = self.descriptionTextView.text!
            }else{
                _noteDescription = DB.notAvailable
            }

            _title = self.titleText.text ?? DB.notAvailable
            
            if let attachImage = self.attachedImage.image {
                //print(attachImage.ur)
               // imageURL = ImageStorage.saveImage(imageName: String( Current.lastNoteID), image: attachImage) ??  DB.notAvailable
            } else {
                imageURL = DB.notAvailable
            }
            
            if self.emojiName != nil{
                emojiName = self.emojiName
            }else{
                emojiName = DB.notAvailable
            }
           
            let currentNote = NoteModel(emoji: emojiName, imageAttachment: "", noteDescription: _noteDescription, noteID:Current.lastNoteID, savingDate: getCurrentDate(), savingTime: getCurrentTime(), title: _title)
            DMBManger.saveToDB(note: currentNote)
        }
        

self.navigationController?.popViewController(animated: true)
    }
    }



extension NewNoteViewController : ImageAttachemet , UIImagePickerControllerDelegate
{
    func addFromPhotos() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
   
    }
    func addFromCamera() {
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
  }
 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       imagePicker.dismiss(animated: true, completion: nil)
   
    let _url = ImageStorage.saveImage(imageName: "2", image: info[.originalImage] as! UIImage)
    
    self.attachedImage.image = ImageStorage.loadImageFromDiskWith(fileName: URL(fileURLWithPath: _url!))

        decriptionViewTrailing.constant = 240.0
    
    
    }
}


extension NewNoteViewController : MoreMenu{
    func shareNote() {
        let activityVC = UIActivityViewController(activityItems: [self.titleText.text ?? " ", self.descriptionTextView.text ?? " ", self.dateLabel.text ?? " "], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    func deleteNote() {
        if let note = self.noteobj
        {
            DMBManger.delete(note: note)
        }
         
        self.navigationController?.popViewController(animated: true)
        
    }
}
    
    

extension NewNoteViewController : EmojiPopupPr {
    func setEmoji(emojiName: String) {
        self.addEmojiButton.setImage(UIImage(named: emojiName), for: .normal)
        self.emojiName = emojiName
     
        
    }

}

extension NewNoteViewController : DeleteImagePopUp
{
    func deleteImage() {
        self.attachedImage.image = nil
        self.decriptionViewTrailing.constant = 0
        self.deleteImageButton.isHidden = true
    }
    
    
    
    
}
