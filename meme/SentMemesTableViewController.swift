//
//  SentMemesTableViewController.swift
//  meme
//
//  Created by Nick Cohen on 5/16/15.
//  Copyright (c) 2015 Nick Cohen. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController : UITableViewController { //, UITableViewDelegate {
    var memes : [Meme]?
    
    var memeToEdit : Meme?
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.delegate = self
        //self.tableView.
        self.tableView.editing = false
        

    }
    
    @IBAction func editMeme(sender: UIButton, forEvent event: UIEvent) {
        memeToEdit = (sender as! MemeButton).meme
        performSegueWithIdentifier("TableViewToEditView", sender: self)
    }
    
    
    
    @IBAction func deleteMeme(sender: UIButton, forEvent event: UIEvent) {
        (UIApplication.sharedApplication().delegate as! AppDelegate).deleteMeme((sender as! MemeButton).meme!, viewController: self, okHandler: {
            self.memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes.memes
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes.memes
        tableView.reloadData()

        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        memeToEdit = nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "TableViewToDetailView" {
            (segue.destinationViewController as! DetailViewController).meme = sender as! Meme?
        } else if segue.identifier == "TableViewToEditView" {
            (segue.destinationViewController as! MemeEditor).preEditMeme = memeToEdit
        }
    }
    
    // open detail view
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //super.tableView(tableView, indexPath)
        //super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        performSegueWithIdentifier("TableViewToDetailView", sender: memes![indexPath.row])
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes!.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int { // Default is 1 if not implemented
        return 1
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier") as! UITableViewCell
        let imageView = cell.viewWithTag(1001) as! UIImageView
        let label = cell.viewWithTag(1002) as! UILabel
        let deleteButton = cell.viewWithTag(1003) as! MemeButton
        let editButton = cell.viewWithTag(1004) as! MemeButton
        
        label.text = memes![indexPath.row].topText + " : " + memes![indexPath.row].bottomText
        imageView.image = memes![indexPath.row].memedImage
        deleteButton.meme = memes![indexPath.row]
        editButton.meme = memes![indexPath.row]
        
        return cell
        
    }
}