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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableViewDelegate = MemeTableViewDelegate()
        tableViewDelegate.delegate = self
        self.tableView.delegate = tableViewDelegate
        self.tableView.dataSource = tableViewDelegate
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        self.tableView.reloadData()
    }
}
