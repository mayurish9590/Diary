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
    @IBOutlet weak var imageContainerHeight: NSLayoutConstraint!
    private var isNoteChanged = false
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var addEmojiButton: UIButton!
    
    @IBOutlet weak var attachedImage: UIImageView!
    
    @IBOutlet weak var addImageButton: UIBarButtonItem!
    
    private var noteId: Int64 = 0
    private let textViewPlaceholderText = "Dear Diary"
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
        floatingButton()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateTheme), name: Notification.Name("Theme"), object: nil)
        
    }
    @objc func updateTheme() {
        currentTheme = Themes.currentTheme()
        self.descriptionView.backgroundColor = currentTheme.navBar
    }
    func initialSetup()
    {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)

        self.descriptionTextView.text = textViewPlaceholderText
        self.descriptionTextView.textColor = UIColor.lightGray
        
        self.titleText.attributedPlaceholder = NSAttributedString(string: "Title",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
        if let note = self.noteobj {
            self.noteId = note.noteID
            titleText.text = note.title
            descriptionTextView.text =  note.noteDescription
            dateLabel.text = formatter.string(from: note.savingDate)
            timeLabel.text = note.savingTime
            
            if (note.imageAttachment) {
                self.attachedImage.image = ImageStorage.loadImageFromDiskWith(imageName: "\(note.noteID)")
                self.imageContainerHeight.constant = 150
                
            }
            self.emojiName = note.emoji
            self.addEmojiButton.imageView?.image = UIImage(named: self.emojiName)
            
        }
        else
        {
            self.noteId =  Date().currentTimeMillis() //self.generateRandomString()
            dateLabel.text = formatter.string(from: getCurrentDate())
            timeLabel.text = getCurrentTime()
        }
        
        if(attachedImage.image == nil)
        {
            self.imageContainerHeight.constant = 0
        }
    }
    
    func floatingButton(){
        
        let btn = UIButton(type: .custom)
        let x = 0.75 * UIScreen.main.bounds.width
        let y = 0.75 * UIScreen.main.bounds.height
        
        btn.frame = CGRect(x: x, y: y, width: 60, height: 60)
        //btn.setTitle("New", for: .normal)
        btn.setTitleColor(Themes.currentTheme().Text, for: .normal)
        btn.backgroundColor = Themes.currentTheme().foreground
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 30
        btn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn.layer.borderWidth = 2.0
        btn.setImage(UIImage(named: "floppy-disk"), for: .normal)
        btn.tintColor = .white
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(self.save), for: .touchUpInside)
        view.addSubview(btn)
        view.bringSubviewToFront(btn)
    }
    @IBAction func onClickHomeButton(_ sender: Any) {
        self.view.endEditing(true)
        
        if (!(self.titleText.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? false) || self.emojiName != nil || self.descriptionTextView.text != textViewPlaceholderText || self.attachedImage.image != nil){
            SaveNote.instance.delegate = self
            SaveNote.instance.showAlert()
        } else {
            self.navigationController?.popViewController(animated: true)

        }
    }
    
    @IBAction func onClickAddEmoji(_ sender: Any) {
        EmojiPopup.instance.delegate = self
        EmojiPopup.instance.showAlert()
    }
    @IBAction func onClickAddPhoto(_ sender: Any) {
        ImageAttachmentPopup.instance.delegate = self
        ImageAttachmentPopup.instance.showAlert(topSpacingForContainer: self.topbarHeight)
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
    
    @objc func save() {
        if(self.noteobj != nil )
        {
            //DMBManger.delete(note: self.noteobj!)
            DMBManger.saveToDB(note: self.noteobj!)
            
        } else{
            
            if (self.titleText.text != "" || self.emojiName != nil || self.descriptionTextView.text != textViewPlaceholderText || self.attachedImage.image != nil){
                
                // Current.lastNoteID = Current.lastNoteID + 1
                let _noteDescription: String
                let _title: String
                var isImageAttached: Bool = false
                let emojiName: String
                if self.descriptionTextView.text != nil{
                    _noteDescription = self.descriptionTextView.text!
                }else{
                    _noteDescription = DB.notAvailable
                }
                
                _title = self.titleText.text ?? DB.notAvailable
                
                if let attachImage = self.attachedImage.image   {
                    //print(attachImage.ur)
                    isImageAttached = ImageStorage.saveImage(imageName: "\(self.noteId)" , image: attachImage)
                }
                
                if self.emojiName != nil{
                    emojiName = self.emojiName
                }else{
                    emojiName = DB.notAvailable
                }
                
                let currentNote = NoteModel(emoji: emojiName, imageAttachment: isImageAttached, noteDescription: _noteDescription, noteID:self.noteId, savingDate: getCurrentDate(), savingTime: getCurrentTime(), title: _title)
                DMBManger.saveToDB(note: currentNote)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func generateRandomString() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<10).map{ _ in letters.randomElement()! })
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
        
        //let _url = ImageStorage.saveImage(imageName: "2", image: info[.originalImage] as! UIImage)
        
        self.attachedImage.image = info[.originalImage] as! UIImage
        self.imageContainerHeight.constant = 150.0
    }
}


extension NewNoteViewController : MoreMenu{
    func shareNote() {
        let activityVC = UIActivityViewController(activityItems: [self.titleText.text ?? " ", self.descriptionTextView.text ?? " ", self.dateLabel.text ?? " "], applicationActivities: nil)
//        self.isNoteEdited = true
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    func deleteNote() {
        if let note = self.noteobj {
            DMBManger.delete(note: note)
        }
        self.navigationController?.popViewController(animated: true)
    }
}



extension NewNoteViewController : EmojiPopupPr {
    func setEmoji(emojiName: String) {
        self.addEmojiButton.setImage(UIImage(named: emojiName), for: .normal)
        if emojiName != "none" {
            self.emojiName = emojiName
        }
    }
    
}

extension NewNoteViewController : DeleteImagePopUp
{
    func deleteImage() {
        self.attachedImage.image = nil
        self.imageContainerHeight.constant = 0
    }
    
}

extension NewNoteViewController: UITextFieldDelegate {
     
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.titleText.resignFirstResponder()
        self.descriptionTextView.becomeFirstResponder()
        return true
    }
}

extension NewNoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = UIColor.lightGray
        }
    }
}
