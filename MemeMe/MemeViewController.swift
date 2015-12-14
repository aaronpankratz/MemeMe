//
//  ViewController.swift
//  MemeMe
//
//  Created by Aaron Pankratz on 11/21/15.
//  Copyright © 2015 Aaron Pankratz. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var shareButtonItem: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: MemeTextField!
    @IBOutlet var bottomTextField: MemeTextField!
    @IBOutlet weak var cameraButtonItem: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    @IBOutlet weak var topToolbarVerticalLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var topToolbarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomToolbarHeightConstraint: NSLayoutConstraint!
    
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    let ToolbarHeight = CGFloat(44)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.attributedPlaceholder = NSAttributedString(string: "TOP", attributes: MemeTextField.memeTextAttributes)
        topTextField.delegate = self.memeTextFieldDelegate
        bottomTextField.attributedPlaceholder = NSAttributedString(string: "BOTTOM", attributes: MemeTextField.memeTextAttributes)
        bottomTextField.delegate = self.memeTextFieldDelegate
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButtonItem.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
        self.shareButtonItem.enabled = self.imagePickerView.image != nil;
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: IBAction

    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func share(sender: AnyObject) {
        let memedImage = generateMemedImage()
        let avcontroller = UIActivityViewController(activityItems: [memedImage], applicationActivities:nil)
        avcontroller.completionWithItemsHandler = { activity, success, items, error in
            self.save(memedImage)
        }
        self.presentViewController(avcontroller, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickerView.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Keyboard notification
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if (self.bottomTextField.isFirstResponder()) {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if (self.bottomTextField.isFirstResponder()) {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    // MARK: helper methods
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func generateMemedImage() -> UIImage
    {
        hideToolbarAndNavbar()

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        showToolbarAndNavbar()
        
        return memedImage
    }
    
    func hideToolbarAndNavbar() {
        self.topToolbar.hidden = true
        self.topToolbarHeightConstraint.constant = 0
        self.topToolbarVerticalLayoutConstraint.constant = -20
        self.bottomToolbar.hidden = true
        self.bottomToolbarHeightConstraint.constant = 0
        self.navigationController?.navigationBar.hidden = true
    }
    
    func showToolbarAndNavbar() {
        self.topToolbarHeightConstraint.constant = ToolbarHeight
        self.topToolbarVerticalLayoutConstraint.constant = 0
        self.topToolbar.hidden = false
        self.bottomToolbarHeightConstraint.constant = ToolbarHeight
        self.bottomToolbar.hidden = false;
        self.navigationController?.navigationBar.hidden = false
    }
    
    func save(memedImage: UIImage) {
        let meme = Meme(topText: self.topTextField.text!,
            bottomText: self.bottomTextField.text!,
            image: self.imagePickerView.image!,
            memedImage: memedImage)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
}

