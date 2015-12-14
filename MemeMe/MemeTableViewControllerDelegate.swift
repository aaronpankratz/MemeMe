//
//  MemeTableViewControllerDelegate.swift
//  MemeMe
//
//  Created by Aaron Pankratz on 12/13/15.
//  Copyright © 2015 Aaron Pankratz. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: MemeTableViewController?
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell")
        cell?.imageView?.image = self.memes[indexPath.row].image
        cell?.textLabel?.text = self.memes[indexPath.row].topText + "..." + self.memes[indexPath.row].bottomText
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = self.delegate!.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        controller.meme = self.memes[indexPath.row]
        self.delegate?.navigationController?.pushViewController(controller, animated: true)
    }
}
