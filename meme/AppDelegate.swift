//
//  AppDelegate.swift
//  meme
//
//  Created by Nick Cohen on 5/15/15.
//  Copyright (c) 2015 Nick Cohen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // TODO: remove this terrible model hack then create a real model, persisting the memes either in local storage or in the cloud
    var memes = Memes()
    
    // centralize delete functionality for reuse, could probably create some kind of helper/utilty class for this in the future, but leaving here for now since the model is here
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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    


}

