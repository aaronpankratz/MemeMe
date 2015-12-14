//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Aaron Pankratz on 12/13/15.
//  Copyright © 2015 Aaron Pankratz. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
    let tableViewDelegate = MemeTableViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDelegate.delegate = self
        self.tableView.delegate = self.tableViewDelegate
        self.tableView.dataSource = self.tableViewDelegate
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
}
