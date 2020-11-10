//
//  ViewControllerExtension.swift
//  Dairy
//
//  Created by Swapnil Waghmare on 29/10/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import Foundation
import  UIKit

extension UIViewController {

    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
