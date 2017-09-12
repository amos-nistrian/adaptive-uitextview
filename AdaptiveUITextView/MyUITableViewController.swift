//
//  MyUITableViewController.swift
//  AdaptiveUITextView
//
//  Created by Amos  on 9/12/17.
//  Copyright © 2017 Arun. All rights reserved.
//

/* This is a self sizing textView in a table view cell, to see how it works move the entry arrow in the storyboard to this viewcontroller */

import UIKit

class MyUITableViewController: UITableViewController, ExpandingCellDelegate {

    @IBOutlet var uiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = false
    }
    
    // to update the table view cell height
    func updateCellHeight(_ indexPath: IndexPath, comment: String) {
        self.uiTableView.beginUpdates()
        self.uiTableView.endUpdates()
    }
    
    // To enable self-sizing table view cells
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableViewAutomaticDimension
    }
    
    // To enable self-sizing table view cells
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableViewAutomaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Custom Table View Cell") as! CustomTableViewCell
        
        cell.textView.text = "AAA"
        
        cell.textView.font = UIFont.systemFont(ofSize: 17.0)
        
        cell.cellIndexPath = indexPath
        cell.delegate = self as ExpandingCellDelegate
        
        return cell
    }

}
