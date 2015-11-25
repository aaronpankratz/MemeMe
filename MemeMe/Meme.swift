//
//  Meme.swift
//  MemeMe
//
//  Created by Aaron Pankratz on 11/24/15.
//  Copyright © 2015 Aaron Pankratz. All rights reserved.
//

import Foundation
import UIKit

class Meme: AnyObject {
    
    var topText: String = ""
    var bottomText: String = ""
    var image: UIImage
    var memedImage: UIImage
    
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
}
