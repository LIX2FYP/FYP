//
//  Sprite.swift
//  CodeBook
//
//  Created by Joey Cheng on 12/1/2016.
//  Copyright © 2016 FYP. All rights reserved.
//

import Foundation
import UIKit

class Sprite {
    let spriteType: String
    var x: CGFloat
    var y: CGFloat
    var rotation: CGFloat
    var rotationStyle: Int //0->left-right 1->dont rotate 2->all around
    var bounce: Bool = false
    var height: CGFloat
    var width: CGFloat
    var spriteImageView: UIImageView!
    
    //say
    var talkingImageView: UIImageView!
    
    
    //Icon
    var iconX: CGFloat = 20
    var iconY: CGFloat = 50
    var spriteIconImageView: UIImageView!
    
    
    //Block
    var blocks: Array<Array<Block>>
    
    
    init(spriteType: String, x: CGFloat, y: CGFloat, rotation: CGFloat, rotationStyle: Int, height: CGFloat, width: CGFloat, blocks: Array<Array<Block>>){
        self.spriteType = spriteType
        self.x = x
        self.y = y
        self.rotation = rotation
        self.rotationStyle = rotationStyle
        self.height = height
        self.width = width
        self.blocks = blocks
        
        self.spriteImageView = createSprite()
        self.spriteIconImageView = createSpriteIcon()
        self.talkingImageView = createTalking()
        
    }
    
    func createSprite() -> UIImageView {
        let spriteImage: UIImage = UIImage(named: spriteType)!
        let spriteImageView: UIImageView = UIImageView()
        
        spriteImageView.image = spriteImage
        spriteImageView.frame.size.height = height
        spriteImageView.frame.size.width = width
        spriteImageView.center.x = x
        spriteImageView.center.y = y
        if rotationStyle == 0{
            if rotation % 360 <= 180{
                spriteImageView.transform = CGAffineTransformMakeRotation(0)
            }
            else {
                spriteImageView.transform = CGAffineTransformMakeScale(-1, 1)
            }
            
        }
        else if rotationStyle == 1{
            spriteImageView.transform = CGAffineTransformMakeRotation(0)
        }
        else {
            spriteImageView.transform = CGAffineTransformMakeRotation((rotation-90) * CGFloat(M_PI / 180))
        }
        spriteImageView.userInteractionEnabled = true
        
        return spriteImageView
    }
    
    func createSpriteIcon() -> UIImageView {
        let spriteIconImage: UIImage = UIImage(named: spriteType)!
        let spriteIconImageView: UIImageView = UIImageView()
        
        spriteIconImageView.image = spriteIconImage
        spriteIconImageView.frame.size.height = spriteIconImage.size.height/1.2
        spriteIconImageView.frame.size.width = spriteIconImage.size.width/1.2
        spriteIconImageView.center.x = iconX
        spriteIconImageView.center.y = iconY
        spriteIconImageView.userInteractionEnabled = true
        
        return spriteIconImageView
    }
    
    func createTalking() -> UIImageView {
        let talkingImage: UIImage = UIImage(named: "box_say")!
        let talkingImageView: UIImageView = UIImageView()
        
        talkingImageView.image = talkingImage
        talkingImageView.frame.size.height = talkingImage.size.height
        talkingImageView.frame.size.width = talkingImage.size.width
        talkingImageView.center.x = spriteImageView.center.x + spriteImageView.image!.size.width
        talkingImageView.center.y = spriteImageView.center.y - spriteImageView.image!.size.height/1.3
        talkingImageView.hidden = true
        
        return talkingImageView
    }
    
    func save() -> String {
        var content: String = "<sprite spriteType='" + spriteType + "' x='" + String(x) + "' y='" + String(y) + "' rotation='" + String(rotation) + "' rotationStyle='" + String(rotationStyle) + "' height='" + String(height) + "' width='" + String(width) + "'>"
        
        var array: String = "false"
        for var outer = 0; outer < blocks.count; outer++ {
            for var inner = 0; inner < blocks[outer].count; inner++ {
                content += "<block array='" + array + "' type='" + blocks[outer][inner].type + "' id='" + String(blocks[outer][inner].id) + "' shape='" + blocks[outer][inner].shape + "' value='" + String(blocks[outer][inner].value) + "' value2='" + String(blocks[outer][inner].value2) + "' x='" + String(blocks[outer][inner].x) + "' y='" + String(blocks[outer][inner].y) + "'></block>"
                array = "false"
            }
            array = "true"
        }
        content += "</sprite>"
        return content
    }
}