//
//  MyUITableViewController.swift
//  AdaptiveUITextView
//
//  Created by Amos  on 9/12/17.
//  Copyright © 2017 Arun. All rights reserved.
//

/* This is a self sizing textView in a table view cell, to see how it works move the entry arrow in the storyboard to this viewcontroller */

import UIKit

class MyUITableViewController: UITableViewController, ExpandingCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    var selectedIndexPath: IndexPath!
    let imagePickerController = UIImagePickerController()
    @IBOutlet var uiTable: UITableView!
    var longPress = UILongPressGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = false
 
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(MyUITableViewController.handleLongPress))
        longPress.minimumPressDuration = 1.50;
        uiTable.addGestureRecognizer(longPress)

    }

    
    // for detecting long press and enabling reordering
    func handleLongPress(sender: UILongPressGestureRecognizer){
        let touchPoint = longPress.location(in: uiTable)
        if let indexPath = uiTable.indexPathForRow(at: touchPoint) {
            // your code here, get the row for the indexPath or do whatever you want
            if (indexPath.row < 3) {
                uiTable.setEditing(true, animated: true)
                shouldEnableReorderingInSection()
            }
        }
    }
    
    
    func shouldEnableReorderingInSection(){
            print("reorder engaged")
            uiTable.setEditing(true, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("Whats up")
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row < 3
    }

    // For selecting the image
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        //nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        // Only allow photos to be picked, not taken.
        //imagePickerController.sourceType = .photoLibrary
        

        present(imagePickerController, animated: true, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary() {
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let cell = self.tableView.cellForRow(at: selectedIndexPath) as! ImageCell
            // Set photoImageView to display the selected image.
            cell.myImage.image = selectedImage
        }else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    // to update the table view cell height
    func updateCellHeight(_ indexPath: IndexPath, comment: String) {
        self.uiTable.beginUpdates()
        uiTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
        self.uiTable.endUpdates()
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
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row < 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Custom Table View Cell") as! CustomTableViewCell
            
            cell.textView.text = "AAA"
            
            cell.textView.font = UIFont.systemFont(ofSize: 17.0)
            
            cell.cellIndexPath = indexPath
            cell.delegate = self as ExpandingCellDelegate
            
            return cell
        }
        
        else {
            if ( indexPath.row == 3) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Custom Table View Cell 2") as! CustomTableViewCell2
                
                cell.textView.text = "AAA"
                
                cell.textView.font = UIFont.systemFont(ofSize: 17.0)
                
                cell.cellIndexPath = indexPath
                cell.delegate = self as ExpandingCellDelegate
                
                return cell
            }
            else if (indexPath.row == 4){
                let cell = tableView.dequeueReusableCell(withIdentifier: "Image Cell") as! ImageCell
                selectedIndexPath = indexPath
                
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Stack Cell") as! StackCell
                
                return cell
            }

        }
    }

}
        
       // NotificationCenter.default.addObserver(self, selector: #selector(x), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

//    func x(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            uiTable.overridePoint = CGPoint(x: 0.0, y: keyboardSize.height+24.0)
////            uiTable.contentInset.bottom += keyboardSize.height
//        }
//    }

//        let rect = tableView.rectForRow(at: indexPath)
//        var point = rect.origin
//        point.y += rect.height + 24.0
//        uiTable.scrollToRow(at: indexPath, at: UITableViewScrollPosition(rawValue: Int(300.0))!, animated: true)
