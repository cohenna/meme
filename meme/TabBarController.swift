//
//  TabBarViewController.swift
//  meme
//
//  Created by Nick Cohen on 5/16/15.
//  Copyright (c) 2015 Nick Cohen. All rights reserved.
//

import Foundation
import UIKit

class TabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tmp : String?
        var tableTab = self.tabBar.items![0] as! UITabBarItem
        tableTab.title = "Table"
        var collecitonTab = self.tabBar.items![1] as! UITabBarItem
        collecitonTab.title = "Collection"
        // TODO: Add image icons for tabs, though it's not required for "Exceeds Expectations"

    }
}