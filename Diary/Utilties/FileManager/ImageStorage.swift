//
//  ImageStorage.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 05/11/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import Foundation
import UIKit
struct ImageStorage {
    static func saveImage(imageName: String, image: UIImage) -> Bool {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return false }
        
        let fileName = ("\(imageName).png")
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return false }
        
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
        do {
            try data.write(to: fileURL)
            return true
        } catch let error {
            print("error saving file with error", error)
            return false
        }
        
    }
    
    static func loadImageFromDiskWith(imageName: String) -> UIImage? {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("\(imageName).png")
           let image    = UIImage(contentsOfFile: imageURL.path)
            return image
        }
         return nil
    }
    
    static func deleteImageFromDisk(imageName: String)
    {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return  }
        
        let fileName = ("\(imageName).png")
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
    }
}
