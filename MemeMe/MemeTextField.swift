//
//  MemeTextField.swift
//  MemeMe
//
//  Created by Aaron Pankratz on 11/23/15.
//  Copyright © 2015 Aaron Pankratz. All rights reserved.
//

import Foundation
import UIKit

class MemeTextField: UITextField {
    static let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultTextAttributes = MemeTextField.memeTextAttributes
        self.textAlignment = NSTextAlignment.Center
    }
}
