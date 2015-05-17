//
//  SentMemesCollectionViewController.swift
//  meme
//
//  Created by Nick Cohen on 5/16/15.
//  Copyright (c) 2015 Nick Cohen. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController : UICollectionViewController {
    
    var memes : [Meme]?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes.memes
        collectionView!.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "CollecitonViewToDetailView" {
            (segue.destinationViewController as! DetailViewController).meme = sender as! Meme?
        }
    }
    
    // open detail view
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("CollecitonViewToDetailView", sender: memes![indexPath.row])
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes!.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCellIdentifier", forIndexPath: indexPath) as! UICollectionViewCell
        let imageView = cell.viewWithTag(2001) as! UIImageView
        imageView.image = memes![indexPath.row].memedImage
        return cell
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}
