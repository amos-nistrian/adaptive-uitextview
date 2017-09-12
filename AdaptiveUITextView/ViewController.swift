//
//  ViewController.swift
//  AdaptiveUITextView
//
//  Created by Arun on 5/18/16.
//  Copyright © 2016 Arun. All rights reserved.
//

/* This is a selfsizing text view in a regular view, to see how it works move the entry arrow in the storyboard to this viewcontroller */

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textEntry: UITextView!
    @IBOutlet weak var textHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismissKeyboard(_ sender: UIButton) {
        self.textEntry.resignFirstResponder()
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("Content Height \(self.textEntry.contentSize.height) ")
        if(self.textEntry.contentSize.height < self.textHeightConstraint.constant) {
            self.textEntry.isScrollEnabled = false
        } else {
            self.textEntry.isScrollEnabled = true
        }
        
        return true
    }
}


