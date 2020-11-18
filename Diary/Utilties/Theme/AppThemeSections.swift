//
//  AppThemeSections.swift
//  Dairy
//
//  Created by Swapnil Waghmare on 30/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import SwiftUI


extension Themes {

    var background: UIImage {
    switch self {
    case .Theme1:
      return UIImage(named: "Basic")!
    case .Theme2:
      return  UIImage(named: "night")!
    case .Theme3:
        return UIImage(named: "wooden")!
    }
  }
    
    var foreground: UIColor {
      switch self {
      case .Theme1:
        return UIColor(named: "theme1Foreground") ?? UIColor.white
      case .Theme2:
        return  UIColor(named: "theme2Foreground") ?? UIColor.blue
      case .Theme3:
        return UIColor(named: "theme3Foreground") ??  UIColor.white
      }
    }
    
    
    var alert: UIColor {
         switch self {
         case .Theme1:
           return UIColor(named: "theme1alert") ?? UIColor.white
         case .Theme2:
           return  UIColor(named: "theme2alert") ?? UIColor.blue
         case .Theme3:
           return UIColor(named: "theme3alert") ??  UIColor.white
         }
       }
    
    
    
    
    
    
    
    var Text: UIColor {
      switch self {
      case .Theme1:
        return UIColor(named: "theme1Text") ?? UIColor.black
      case .Theme2:
        return UIColor(named: "theme2Text") ?? UIColor.black
      case .Theme3:
        return UIColor(named: "theme3Text") ?? UIColor.black
      }
    }
    
    var isLocked: Bool {
        switch self {
        case .Theme1:
        return false
        case .Theme2:
        return false
        case .Theme3:
        return true
        }
    }
    
    var name: String {
        switch self {
        case .Theme1:
        return "Theme1"
        case .Theme2:
        return "Theme2"
        case .Theme3:
        return "Theme3"
        }
    }
    
    static func numberOfRows() -> Int {
        return self.allCases.count
    }
    
    static func getTheme(_ index: Int) -> Themes {
    return self.allCases[index]
    }
    static func currentTheme() -> Themes {
        if let index = UserDefaults.standard.value(forKey: KEYS.keyCurrentTheme) as? Int {
            return self.allCases[index]
        } else {
            return Themes.Theme1
        }
    }
    static func SetTheme(index: Int){
        UserDefaults.standard.setValue(index, forKey: KEYS.keyCurrentTheme)
        NotificationCenter.default.post(name: Notification.Name("Theme"), object: nil)
    }
}
