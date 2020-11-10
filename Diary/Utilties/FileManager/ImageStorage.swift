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
   static func saveImage(imageName: String, image: UIImage) -> String? {
  
     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }

        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return nil }

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
        } catch let error {
            print("error saving file with error", error)
        }
    return fileURL.absoluteString
    
    }
    
static func loadImageFromDiskWith(fileName: URL) -> UIImage? {
 //if FileManager.default.fileExists(atPath: fileName.path) {
    let image = UIImage(contentsOfFile: fileName.path
    )
        return image
        
       // }
        
       // return nil
    }
 
    static func deleteImageFromDisk(fileURL: URL)
{
    
    if FileManager.default.fileExists(atPath: fileURL.path ) {
    do {
        try FileManager.default.removeItem(atPath: fileURL.path )
                   print("Removed old image")
               } catch let removeError {
                   print("couldn't remove file at path", removeError)
               }
        }
}   
}
