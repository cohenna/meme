//
//  DetailViewController.swift
//  meme
//
//  Created by Nick Cohen on 5/17/15.
//  Copyright (c) 2015 Nick Cohen. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController : UIViewController {
    var meme : Meme?
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = meme?.memedImage
        self.tabBarController?.hidesBottomBarWhenPushed
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)
        
        // make navigation bar translucent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // unhide status bar
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.None)
    }
    
    @IBAction func deletePhoto(sender: UIButton) {
        (UIApplication.sharedApplication().delegate as! AppDelegate).deleteMeme(meme!, viewController: self, okHandler: {
            self.navigationController?.popViewControllerAnimated(true)
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "EditPhotoFromDetailView" {
            (segue.destinationViewController as! MemeEditor).preEditMeme = sender as! Meme?
        }
    }
    
    @IBAction func editPhoto(sender: UIButton) {
        performSegueWithIdentifier("EditPhotoFromDetailView", sender: meme)
    }
}