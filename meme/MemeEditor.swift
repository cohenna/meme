//
//  ViewController.swift
//  meme
//
//  Created by Nick Cohen on 5/15/15.
//  Copyright (c) 2015 Nick Cohen. All rights reserved.
//

import UIKit

class MemeEditor: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //@IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var currentMeme : Meme?
    
    // used to determine whether this is an edit or a new meme
    var preEditMeme : Meme?
    
    @IBOutlet weak var imagePickerView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if !UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front) {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            cameraButton.enabled = false
        }
        
        self.tabBarController?.hidesBottomBarWhenPushed
        
        reset()
        
        if let pem = preEditMeme {
            topTextField.text = pem.topText
            bottomTextField.text = pem.bottomText
            imagePickerView.image = pem.originalImage
            shareButton.enabled = true
        }
        
        
        
        topTextField.delegate = self
        bottomTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Subscribe to keyboard notifications to allow the view to raise when necessary
        self.subscribeToKeyboardNotifications()
        
        // hide status bar completely
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)
        
        // make navigation bar translucent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true

    }
    
    func reset() {
        shareButton.enabled = false
        imagePickerView.image = nil
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -5.0,
        ]
        
        
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
        
        // unhide status bar
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.None)
        
        // undo make navigation bar translucent
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.translucent = false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true;
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        textField.text = ""
        return true;
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickerView.image = image
            shareButton.enabled = true
        }

    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func pickAnImageWithCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)

    }
    
    
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        toolbar.hidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        toolbar.hidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        return memedImage
    }
    
    
    func save(activityType: String!, completed: Bool, returnedItems: [AnyObject]!, activityError: NSError!) {
        dismissViewControllerAnimated(true, completion: nil)
        if (completed) {
            if let pem = preEditMeme {
                // we did an edit, so we want to replace the existing meme, not create a new one
                var i = 0
                for m in (UIApplication.sharedApplication().delegate as! AppDelegate).memes.memes {
                    
                    if m == pem {
                        break
                    }
                    i += 1
                }
                (UIApplication.sharedApplication().delegate as! AppDelegate).memes.memes[i] = currentMeme!
                preEditMeme = nil
                self.navigationController?.popToRootViewControllerAnimated(true)
            } else {
            
                (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(currentMeme!)
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    
    @IBAction func share(sender: UIButton) {
        var memedImage = generateMemedImage()
        currentMeme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, originalImage: imagePickerView.image!, memedImage: memedImage)
        var avc = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        navigationController?.presentViewController(avc, animated: true, completion: nil)
        avc.completionWithItemsHandler = save
    }
    
    
    @IBAction func cancel(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }

}

