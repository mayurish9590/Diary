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
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var addEmojiButton: UIButton!
    
    @IBOutlet weak var attachedImage: UIImageView!
    
    @IBOutlet weak var addImageButton: UIBarButtonItem!
    
    @IBOutlet weak var decriptionViewTrailing: NSLayoutConstraint!
    
  //  @IBOutlet weak var descriptionViewBottamConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    var saveNoteAlert : UIView!
    var addImagePopup : UIView!
    var morMenuPopupView : UIView!
    var noteobj : Note?
    let imagePicker = UIImagePickerController()
    var attachimageData : Data!
    var emojiName : String!
    var emojiPopupview : UIView!
    var ContentViewTapGesture : UITapGestureRecognizer!
    @IBOutlet weak var deleteImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.attributedPlaceholder =
        NSAttributedString(string: "Title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        initialSetup()
        
    }
    
    
    func initialSetup()
    {
        if ( self.noteobj == nil)
        {
            timeLabel.text = getCurrentTime()
            dateLabel.text = getCurrentDate()
            
        }
            
        else{
            if let _title = self.noteobj?.title {
                if (_title != DB.notAvailable){
                    timeLabel.text = _title } }
           
            if let _description = self.noteobj?.noteDescription {
                if (_description != DB.notAvailable) {
                    descriptionTextView.text = _description } }
            
            if let _dateLabel = self.noteobj?.savingDate
            {
                dateLabel.text = _dateLabel
            }
            if let _timeLabel = self.noteobj?.savingTime{
                timeLabel.text = _timeLabel
            }
            
            if let _attchimageData = self.noteobj?.imageAttachment {
                self.attachedImage.image = UIImage(data: _attchimageData)
            }
            
            if let _emojiName = self.noteobj?.emoji {
                if( _emojiName != DB.notAvailable){
                  
                    self.emojiName = _emojiName
                    self.addEmojiButton.imageView?.image = UIImage(named: _emojiName)
                }
            }
        }
        
        if(attachedImage.image == nil)
        {
            decriptionViewTrailing.constant = 10
          
            self.deleteImageButton.isHidden = true
            
        }
        //self.view.backgroundColor = Current.alertBackgroundColor
        self.ContentViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(removeAlertFromParentView) )
      
    }
 
    @objc func removeAlertFromParentView()
    {
        if self.saveNoteAlert != nil {
            self.saveNoteAlert.isHidden = true
        }
        if self.addImagePopup != nil{
            self.addImagePopup.isHidden = true
        }
        if self.emojiPopupview != nil{
            self.emojiPopupview.isHidden = true
        }
        self.view.removeGestureRecognizer(self.ContentViewTapGesture)
        self.descriptionView.removeGestureRecognizer(self.ContentViewTapGesture)
         self.descriptionTextView.isUserInteractionEnabled = true
        self.titleText.isUserInteractionEnabled = true
    }

    @IBAction func onClickHomeButton(_ sender: Any) {
        SaveNote.instance.delegate = self
        SaveNote.instance.showAlert()
        /*
        if self.saveNoteAlert == nil {
            self.saveNoteAlert = saveNote.getAlertView()
            saveNote.delegate = self
        }
        if self.saveNoteAlert != nil{
            self.view.addSubview(self.saveNoteAlert)
            
        } else {
             
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: VC.home)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        */
    }
    
    @IBAction func onClickAddEmoji(_ sender: Any) {
        EmojiPopup.instance.delegate = self
        EmojiPopup.instance.showAlert()
        /*
        if self.emojiPopupview == nil {
            self.emojiPopupview = EmojiPopup.instance.getView()
            }
            
        if let _emojiPopupView = self.emojiPopupview {
              self.view.addSubview(_emojiPopupView)
            _emojiPopupView.isHidden = false
             self.view.addGestureRecognizer(self.ContentViewTapGesture)
            self.descriptionView.addGestureRecognizer(self.ContentViewTapGesture)
            self.descriptionTextView.isUserInteractionEnabled = false
            
            self.titleText.isUserInteractionEnabled = false
          }
 */
    }
    
    
    
    @IBAction func onClickAddPhoto(_ sender: Any) {
        ImageAttachmentPopup.instance.delegate = self
        ImageAttachmentPopup.instance.showAlert(topSpacingForContainer: self.topbarHeight)
        /*
        if self.addImagePopup == nil {
            self.addImagePopup = ImageAttachmentPopup.getView()
            
        }
        
        if let _imageAttchmentPopupView = self.addImagePopup
        {
            _imageAttchmentPopupView.isHidden = false
            self.view.addSubview(_imageAttchmentPopupView)
             self.view.addGestureRecognizer(self.ContentViewTapGesture)
             self.descriptionView.addGestureRecognizer(self.ContentViewTapGesture)
             self.descriptionTextView.isUserInteractionEnabled = false
             self.titleText.isUserInteractionEnabled = false
        }
    */
    }
 
    
    @IBAction func onClickMoreMenu(_ sender: Any) {
        MoreMenuPopup.instance.delegate = self
        MoreMenuPopup.instance.showAlert(topSpacingForContainer: self.topbarHeight)
        /*
        if self.morMenuPopupView == nil {
        self.morMenuPopupView = MoreMenuPopup.getView() }
       if let _moreMenuPopupView = self.morMenuPopupView
              {
                  self.view.addSubview(_moreMenuPopupView)
                   self.view.addGestureRecognizer(self.ContentViewTapGesture)
                   self.descriptionView.addGestureRecognizer(self.ContentViewTapGesture)
                   self.descriptionTextView.isUserInteractionEnabled = false
                   self.titleText.isUserInteractionEnabled = false
              }
 */
    }
    
    @IBAction func onClickDeleteImage(_ sender: Any) {
        DeleteImageAttachment.instance.delegate = self
        DeleteImageAttachment.instance.showAlert()
    }
    
    
    func  getCurrentDate() -> (String)
    {
        let dateformatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            return formatter}()
        let currDate = dateformatter.string(from : Date())
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
//        saveNoteAlert.isHidden = true
        /*
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: VC.home)
        self.navigationController?.pushViewController(vc, animated: true)
 */
        self.navigationController?.popViewController(animated: true)
        
    }

    func save() {
        if(self.noteobj != nil )
        {
            DMBManger.delete(note: self.noteobj!)
            DMBManger.saveToDB(note: self.noteobj!)
            
        } else{
        Current.lastNoteID = Current.lastNoteID + 1
        if let nsObjContext = DMBManger.nsobjContext{
            let currentNote = Note(context: nsObjContext)
            currentNote.noteID = Int64(Current.lastNoteID)
            currentNote.savingDate = getCurrentDate()
            currentNote.savingTime = getCurrentTime()
            
            
            if let _noteDescription = self.descriptionTextView.text{ currentNote.noteDescription = _noteDescription }else{
                currentNote.noteDescription = DB.notAvailable
            }
            if let _title = self.title{ currentNote.title = _title }else{
                currentNote.title = DB.notAvailable
            }
            if self.attachimageData != nil{                currentNote.imageAttachment = self.attachimageData
            }
            
            if self.emojiName != nil{
                currentNote.emoji = self.emojiName
            }else{
                currentNote.emoji = DB.notAvailable
            }
           
            DMBManger.saveToDB(note: currentNote)
        }
        }
        /*
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeViewController")
        self.navigationController?.pushViewController(vc, animated: true)
 */
        self.navigationController?.popViewController(animated: true)
        
    }

}

extension NewNoteViewController : ImageAttachemet , UIImagePickerControllerDelegate
{
      
   
    func addFromPhotos() {
       
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
       // self.addImagePopup.isHidden = true
    }
    
    func addFromCamera() {
      
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        //self.addImagePopup.isHidden = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       imagePicker.dismiss(animated: true, completion: nil)
        self.attachedImage.image = info[.originalImage] as? UIImage
           
        
        self.attachimageData = self.attachedImage.image?.pngData()
        decriptionViewTrailing.constant = 240.0
    }
    
    
    
}


extension NewNoteViewController : MoreMenu{
    func shareNote() {
        let activityVC = UIActivityViewController(activityItems: [self.titleText.text ?? " ", self.descriptionTextView.text ?? " ", self.dateLabel.text ?? " "], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    func deleteNote() {
        if(self.noteobj != nil )
        {
            DMBManger.delete(note: self.noteobj!)
        }
         
        self.navigationController?.popViewController(animated: true)
        
    }
}
    
    

extension NewNoteViewController : EmojiPopupPr {
    func setEmoji(emojiName: String) {
        self.addEmojiButton.setImage(UIImage(named: emojiName), for: .normal)
        self.emojiName = emojiName
      //  self.emojiPopupview.isHidden = true
        
    }

}

extension NewNoteViewController : DeleteImagePopUp
{
    func deleteImage() {
        self.attachedImage.image = nil
        self.decriptionViewTrailing.constant = 0
    }
    
    
    
    
}
