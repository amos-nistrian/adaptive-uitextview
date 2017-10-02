//
//  CustomTableViewCell.swift
//  AdaptiveUITextView
//
//  Created by Amos  on 9/12/17.
//  Copyright © 2017 Arun. All rights reserved.
//

import UIKit

protocol ExpandingCellDelegate {
    func updateCellHeight (_ indexPath: IndexPath, comment:String)
    //func shouldEnableReorderingInSection(row: Int)
}

class CustomTableViewCell: UITableViewCell, UITextViewDelegate  {
    
    
    var delegate: ExpandingCellDelegate!
    var cellIndexPath: IndexPath!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textHeightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("Content Height \(self.textView.contentSize.height) ")
        if(self.textView.contentSize.height < self.textHeightConstraint.constant) {
            self.textView.isScrollEnabled = false
        } else {
            self.textView.isScrollEnabled = true
        }
        
        UIView.setAnimationsEnabled(false)
        self.delegate.updateCellHeight(self.cellIndexPath, comment: textView.text)
        UIView.setAnimationsEnabled(true)
        
        return true
    }
    
//    @IBAction func handleLongPress(_ sender: UILongPressGestureRecognizer) {
//        print("Long Press Detected")
//        delegate?.shouldEnableReorderingInSection(row: cellIndexPath.row)
//    }
}

