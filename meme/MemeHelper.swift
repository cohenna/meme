//
//  MemeHelper.swift
//  meme
//
//  Created by Nick Cohen on 5/17/15.
//  Copyright (c) 2015 Nick Cohen. All rights reserved.
//

import Foundation
import UIKit


// simple class to place some code that can be reused by multiple View Controllers
class MemeHelper {
    // centralize delete functionality for reuse, could probably create some kind of helper/utilty class for this in the future
    func deleteMeme(meme : Meme, viewController : UIViewController, okHandler : ((Void) -> Void)!) {
        var deleteAlert = UIAlertController(title: "Delete Photo", message: "Please confirm you wish to delete this photo.  This action cannot be undone.", preferredStyle: UIAlertControllerStyle.Alert)
        
        deleteAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
            self.memes.removeMeme(meme)
            okHandler()
        }))
        
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        
        viewController.presentViewController(deleteAlert, animated: true, completion: nil)
        
    }
}