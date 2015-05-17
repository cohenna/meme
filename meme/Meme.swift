//
//  Meme.swift
//  meme
//
//  Created by Nick Cohen on 5/16/15.
//  Copyright (c) 2015 Nick Cohen. All rights reserved.
//

import Foundation
import UIKit

// handy function to compare two memes
func ==(meme : Meme, meme2 : Meme) -> Bool {
    return meme.originalImage == meme2.originalImage
        && meme.memedImage == meme2.memedImage
        && meme.bottomText == meme2.bottomText
        && meme.topText == meme2.topText
}

class Meme {
    var originalImage : UIImage
    var memedImage : UIImage
    var topText : String
    var bottomText : String
    
    init(topText : String, bottomText : String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    
    
    
}

// starting to look more like a real model, still pretty...crude
class Memes {
    var memes : [Meme]
    
    init() {
        memes = [Meme]()
    }
    
    func append(meme: Meme) {
        memes.append(meme)
    }
    
    func removeMeme(meme : Meme) {
        var i = 0
        for m in memes {
            if m == meme {
                break
            }
            i += 1
        }
        if i < memes.count {
            memes.removeAtIndex(i)
        }
    }
}