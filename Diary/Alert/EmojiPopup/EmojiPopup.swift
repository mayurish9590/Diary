//
//  EmojiPopup.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 26/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit
import Foundation

class EmojiPopup: UIView {
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var emojiCollectionCOntainer: UIView!
    @IBOutlet weak var emojiCollectionView: UICollectionView!
    
    static var instance = EmojiPopup()

    var delegate : EmojiPopupPr?
    
    
    let emoji : [String] = ["none","001-happy-18", "002-cool-5", "003-happy-17", "004-surprised-9","005-shocked-4", "006-shocked-3","007-nervous-2",
                            "008-nervous-1","009-angry-6","010-drool","011-tired-2","012-tongue-7","013-tongue-6","014-tongue-5","015-smile-1","016-sleeping-1","017-nervous","018-surprised-8","019-tongue-4","020-happy-16","021-wink-1","022-laughing-2","023-laughing-1","024-sweat-1","025-happy-15","026-happy-14","027-laughing","028-happy-13","029-happy-12","030-crying-8","031-crying-7","032-bored","033-cool-4","034-angry-5","035-sad-14","036-angry-4","037-happy-11","038-angry-3","039-cyclops-1","040-surprised-7","041-thinking-2","042-book","043-baby-boy","044-dead-1","045-star","046-dubious","047-phone-call","048-moon","049-robot","050-flower","051-happy-10","052-happy-9","053-tired-1","054-ugly-3","055-tongue-3","056-vampire","057-music-1","057-music-1","059-nurse","060-sad-13","060-sad-13","062-happy-8","063-hungry","064-police","065-crying-6","066-happy-7","067-sun","068-father-2","069-happy-6","070-late","070-late","072-sick-3","073-sad-12","074-in-love-10","075-shocked-2","076-happy-5","077-shocked-1","078-cool-3","079-crying-5","080-zombie","081-pain","082-cyclops","083-sweat","084-thief","085-sad-11","086-kiss-4","087-father-1","088-father","089-angel-1","090-happy-4","091-sad-10","092-outrage-1","093-ugly-2","094-ugly-1","095-scared","096-tongue-2","097-sad-9","098-nerd-9","099-greed-2","100-whistle","101-nerd-8","102-muted-4","103-in-love-9","104-in-love-8","105-kiss-3","106-in-love-7","107-ugly","108-nerd-7","109-nerd-6","110-crying-4","111-muted-3","112-nerd-5","113-kiss-2","114-greed-1","115-pirate-1","116-music","117-confused-2","118-nerd-4","119-greed","120-nerd-3","121-crying-3","122-cheering","123-surprised-6","124-muted-2","125-sick-2","126-graduated","127-angry-2","128-in-love-6","129-cool-2","130-confused-1","131-sad-8","132-nerd-2","133-birthday-boy","134-surprised-5","135-selfie","136-tongue-1","137-smart-1","138-smart","139-surprised-4","140-3d-glasses","141-in-love-5","142-sleeping","143-pirate","144-santa-claus","145-wink","146-in-love-4","147-tired","148-bang","149-baby","150-tongue","151-sick-1","152-outrage","153-injury","154-dead","155-rich-1","156-sick","157-angel","158-nerd-1","159-crying-2","160-crying-1","161-muted-1","162-surprised-3","163-crying","164-sad-7","165-cool-1","166-happy-3","167-thinking-1","168-muted","169-confused","170-happy-2","171-thinking","172-nerd","173-in-love-3","174-hypnotized","175-cool","176-shocked","177-easter","178-surprised-2","179-surprised-1","180-surprised","181-furious","182-sad-6","183-sad-5","184-sad-4","185-sad-3","186-angry-1","187-rich","188-sad-2","189-happy-1","190-sad-1","191-sad","192-smile","194-happy","195-kiss-1","196-in-love-1","197-in-love","198-kiss","199-angry","200-sleepy"]
    
    
    
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        Bundle.main.loadNibNamed("EmojiPopup", owner: self, options: nil)
        commonInit()
    }
    
    private func commonInit() {

        self.emojiCollectionView.delegate = self
        self.emojiCollectionView.dataSource = self
        self.emojiCollectionView.register(UINib(nibName: "EmojiCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmojiCell")

        emojiCollectionCOntainer.layer.cornerRadius = 10
        emojiCollectionCOntainer.layer.borderColor = UIColor.white.cgColor
        emojiCollectionCOntainer.layer.borderWidth = 2
      
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(dismissPopoup))
        shadowView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func dismissPopoup() {
        parentView.endEditing(true)
        parentView.removeFromSuperview()
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func upadteTheme()
    {
           let currenttheme = Themes.currentTheme()
                    emojiCollectionCOntainer.backgroundColor = currenttheme.alert
    }
    func showAlert() {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            window.addSubview(parentView)
        }
        upadteTheme()
    }
    
}


extension EmojiPopup : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return emoji.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = emojiCollectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as! EmojiCollectionViewCell
        cell.emojiImageView.image = UIImage(named: emoji[indexPath.row])
    return cell
}
}

extension EmojiPopup : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _delegate = self.delegate{
            _delegate.setEmoji(emojiName: emoji[indexPath.row])
            self.dismissPopoup()
        }
    }
}
