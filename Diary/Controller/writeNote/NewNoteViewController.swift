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
    @IBOutlet weak var viewImageHeader: UIView!
    
    
    @IBOutlet weak var moreMenuButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageContainerHeight: NSLayoutConstraint!
    private var isExistingNoteImageChanged = false
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var addEmojiButton: UIButton!
    
    @IBOutlet weak var attachedImage: UIImageView!
    
    @IBOutlet weak var addImageButton: UIBarButtonItem!
     var dateFromCalender: Date?
    private var noteId: Int64 = 0
    private var isNoteImageUpdated = false
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
    @IBOutlet weak var heightConstraintOfNoteView: NSLayoutConstraint!
    var previousRect = CGRect.zero
    var noteViewHeightOriginal = 0
    var delegate: DataRefresh?
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
        self.view.backgroundColor = currentTheme.background
        self.viewImageHeader.backgroundColor = currentTheme.alert
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
        self.heightConstraintOfNoteView.constant = (0.6 * UIScreen.main.bounds.height) - 100
        
        if let note = self.noteobj {
            self.noteId = note.noteID
            titleText.text = note.title
            descriptionTextView.text =  note.noteDescription
            dateLabel.text = formatter.string(from: note.savingDate)
            timeLabel.text = note.savingTime
            
            if (note.imageAttachment) {
                self.attachedImage.image = ImageStorage.loadImageFromDiskWith(imageName: "\(note.noteID)")
                self.imageContainerHeight.constant = 150
                self.heightConstraintOfNoteView.constant = self.heightConstraintOfNoteView.constant - self.imageContainerHeight.constant

            }
            self.emojiName = note.emoji
            self.addEmojiButton.setImage(UIImage(named: self.emojiName), for: .normal)
        }
        else
        {
            if let calenderDate =  self.dateFromCalender {
                dateLabel.text = formatter.string(from:calenderDate)
                self.noteId =  calenderDate.currentTimeMillis() //self.generateRandomString()

            } else {
                dateLabel.text = formatter.string(from: getCurrentDate())
                self.noteId =  Date().currentTimeMillis() //self.generateRandomString()
            }
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
        if(self.noteobj != nil){
            if ((self.titleText.text?.trimmingCharacters(in: .whitespacesAndNewlines) != self.noteobj?.title) || self.emojiName != self.noteobj?.emoji || self.descriptionTextView.text != self.noteobj?.noteDescription || self.isExistingNoteImageChanged)  {
                
                SaveNote.instance.delegate = self
                SaveNote.instance.showAlert()
                
            } else {
                if let del = self.delegate {
                    del.refreshData()
                }
                self.navigationController?.popViewController(animated: true)
                
            }
            
        } else {
            
            if (!(self.titleText.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? false) || self.emojiName != nil || self.descriptionTextView.text != textViewPlaceholderText || self.attachedImage.image != nil){
                SaveNote.instance.delegate = self
                SaveNote.instance.showAlert()
            } else {
                self.navigationController?.popViewController(animated: true)
                if let del = self.delegate {
                    del.refreshData()
                }
            }
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
    
    
    @IBAction func onClickExpandImage(_ sender: Any) {
        if let image = self.attachedImage.image {
            ImageViewPoppup.instance.showAlert(image:image  )

        }
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
        if let del = self.delegate {
            del.refreshData()
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func save() {
        if(self.noteobj != nil )
        {
            //DMBManger.delete(note: self.noteobj!)
            self.noteobj?.title = self.titleText.text ?? ""
            self.noteobj?.noteDescription = self.descriptionTextView.text
           
                 self.noteobj?.savingDate = self.getCurrentDate()
           
            self.noteobj?.savingTime = self.getCurrentTime()
            
            if let attachImage = self.attachedImage.image, let imageName = self.noteobj?.noteID   {
                //print(attachImage.ur)
                noteobj?.imageAttachment =  ImageStorage.saveImage(imageName: "\(imageName)" , image: attachImage)
            } else {
                noteobj?.imageAttachment = false
            }
            if self.emojiName != nil{
                noteobj?.emoji = self.emojiName
            }
            DMBManger.update(note: noteobj!)
            if let del = self.delegate {
                del.refreshData()
            }
            self.navigationController?.popViewController(animated: true)
            
            
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
                let currnetDate : Date!
                 if let calDate = dateFromCalender {
                    currnetDate = calDate
                    }else {
                                currnetDate = getCurrentDate()  }
               
                if self.emojiName != nil{
                    emojiName = self.emojiName
                }else{
                    emojiName = DB.notAvailable
                }
                let currentNote = NoteModel(emoji: emojiName, imageAttachment: isImageAttached, noteDescription: _noteDescription, noteID:self.noteId, savingDate: currnetDate, savingTime: getCurrentTime(), title: _title)
                DMBManger.saveToDB(note: currentNote)
                if let del = self.delegate {
                    del.refreshData()
                }
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
        self.heightConstraintOfNoteView.constant = self.heightConstraintOfNoteView.constant - self.imageContainerHeight.constant
        if let existingNote = noteobj{
            if existingNote.imageAttachment {
                isExistingNoteImageChanged = true
            }
        }
    }
}


extension NewNoteViewController : MoreMenu{
    func shareNote() {
        var activityItems: [Any] = [self.titleText.text ?? " ", self.descriptionTextView.text ?? " ", self.dateLabel.text ?? " "]
        
        if let image = self.attachedImage.image {
            activityItems.append(image)
        }
        
        if let date = self.titleText.text, !date.isEmpty {
            activityItems.append("\n")
            activityItems.append(date)
        }
        if let title = self.titleText.text, !title.isEmpty {
            activityItems.append("\n")
            activityItems.append(title)
        }
        if let description = self.descriptionTextView.text, !description.isEmpty {
            activityItems.append("\n")
            activityItems.append(description)
        }
        
        
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
//        self.isNoteEdited = true
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    func deleteNote() {
        if let note = self.noteobj {
            DMBManger.delete(note: note)
        }
        if let del = self.delegate {
            del.refreshData()
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
        self.heightConstraintOfNoteView.constant = (0.6 * UIScreen.main.bounds.height) - 100
        if let existingNote = noteobj{
            if existingNote.imageAttachment {
                isExistingNoteImageChanged = true
            }
        }
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
    func textViewDidChange(_ textView: UITextView) {
        if (self.attachedImage.image != nil) {
            let pos = textView.endOfDocument
            let currentRect = textView.caretRect(for: pos)
            self.previousRect = self.previousRect.origin.y == 0.0 ? currentRect : self.previousRect
            if currentRect.origin.y > self.previousRect.origin.y {
                //new line reached, write your code
                print("Started New Line")
                TextViewPoppup.instance.delegate = self
                TextViewPoppup.instance.showAlert(text: self.descriptionTextView.text ?? "")
            }
            self.previousRect = currentRect
        }
            
        }
}


extension UITextView{

    func numberOfLines() -> Int{
        if let fontUnwrapped = self.font{
            return Int(self.contentSize.height / fontUnwrapped.lineHeight)
        }
        return 0
    }

}

extension NewNoteViewController: TextViewProtocol {
    func textViewPopupDismissed(text: String) {
        self.descriptionTextView.text = text
        self.descriptionTextView.selectedRange = NSMakeRange(self.descriptionTextView.text.count , 0);
        self.descriptionTextView.becomeFirstResponder()

    }
    
    
}
