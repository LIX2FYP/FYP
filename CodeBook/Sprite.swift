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
    var talkingView: UIView!
    var talkingImageView: UIImageView!
    var talkingLabel: UILabel!
    
    var costume: Array<UIImage> = []
    var currentCostume: Int
    
    
    //Icon
    var iconX: CGFloat = 20
    var iconY: CGFloat = 50
    var spriteIconImageView: UIImageView!
    
    
    //Block
    var blocks: Array<Array<Block>>
    
    
    init(spriteType: String, x: CGFloat, y: CGFloat, rotation: CGFloat, rotationStyle: Int, height: CGFloat, width: CGFloat, blocks: Array<Array<Block>>, costume: Int){
        self.spriteType = spriteType
        self.x = x
        self.y = y
        self.rotation = rotation
        self.rotationStyle = rotationStyle
        self.height = height
        self.width = width
        self.blocks = blocks
        self.currentCostume = costume
        
        if spriteType == "redbird"{
            //self.costume.append(UIImage(named: "redbird")!)
            self.costume.append(UIImage(named: "bat_1")!)
            self.costume.append(UIImage(named: "bat_2")!)
        }
        else if spriteType == "turtle"{
            self.costume.append(UIImage(named: "turtle")!)
        }
        else if spriteType == "rabbit"{
            self.costume.append(UIImage(named: "rabbit")!)
        }
        else if spriteType == "crow_standing"{
            self.costume.append(UIImage(named: "crow_standing")!)
        }
        else if spriteType == "pig_mum"{
            self.costume.append(UIImage(named: "pig_mum")!)
        }
        else if spriteType == "pig_first"{
            self.costume.append(UIImage(named: "pig_first")!)
        }
        else if spriteType == "pig_second"{
            self.costume.append(UIImage(named: "pig_second")!)
        }
        else if spriteType == "pig_third"{
            self.costume.append(UIImage(named: "pig_third")!)
        }
        else if spriteType == "wolf"{
            self.costume.append(UIImage(named: "wolf")!)
        }
        else if spriteType == "boy"{
            self.costume.append(UIImage(named: "boy")!)
        }
        else if spriteType == "sheep"{
            self.costume.append(UIImage(named: "sheep")!)
        }
        else if spriteType == "prince"{
            self.costume.append(UIImage(named: "prince")!)
        }
        else if spriteType == "princess"{
            self.costume.append(UIImage(named: "princess")!)
        }
        else if spriteType == "devil"{
            self.costume.append(UIImage(named: "devil")!)
        }
        else if spriteType == "devil_blue"{
            self.costume.append(UIImage(named: "devil_blue")!)
        }
        
        self.spriteImageView = createSprite()
        self.spriteIconImageView = createSpriteIcon()
        self.talkingView = createTalking()
    }
    
    func createSprite() -> UIImageView {
        let spriteImage: UIImage = costume[currentCostume]
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
    
    func createTalking() -> UIView {
        let talkingView: UIView = UIView()
        let talkingImage: UIImage = UIImage(named: "box_say")!
        let talkingImageView: UIImageView = UIImageView()
        let talkingLabel: UILabel = UILabel()
        
        talkingView.frame.size.height = talkingImage.size.height
        talkingView.frame.size.width = talkingImage.size.width
        talkingView.center.x = spriteImageView.center.x + spriteImageView.image!.size.width
        talkingView.center.y = spriteImageView.center.y - spriteImageView.image!.size.height/1.3
        talkingView.hidden = true
        
        talkingImageView.image = talkingImage
        talkingImageView.frame.size.height = talkingImage.size.height
        talkingImageView.frame.size.width = talkingImage.size.width
        talkingImageView.frame.origin.x = 0
        talkingImageView.frame.origin.y = 0
        talkingView.addSubview(talkingImageView)
        
        talkingLabel.frame.size.height = talkingImage.size.height
        talkingLabel.frame.size.width = talkingImage.size.width
        talkingLabel.frame.origin.x = 0
        talkingLabel.frame.origin.y = -13
        talkingView.addSubview(talkingLabel)
        
        self.talkingImageView = talkingImageView
        self.talkingLabel = talkingLabel
        
        return talkingView
    }
    
    func save() -> String {
        var content: String = "<sprite spriteType='" + spriteType
        content += "' x='" + String(x)
        content += "' y='" + String(y)
        content += "' rotation='" + String(rotation)
        content += "' rotationStyle='" + String(rotationStyle)
        content += "' height='" + String(height)
        content += "' width='" + String(width)
        content += "' costume='" + String(currentCostume) + "'>"
        
        var array: String = "false"
        for var outer = 0; outer < blocks.count; outer++ {
            for var inner = 0; inner < blocks[outer].count; inner++ {
                content += "<block array='" + array
                content += "' type='" + blocks[outer][inner].type
                content += "' id='" + String(blocks[outer][inner].id)
                content += "' shape='" + blocks[outer][inner].shape
                if blocks[outer][inner].blockView.textFieldValue != nil{
                    content += "' value='" + blocks[outer][inner].blockView.textFieldValue!
                }
                else {
                    content += "' value1='nil"
                }
                if blocks[outer][inner].blockView.textFieldValue2 != nil{
                    content += "' value2='" + blocks[outer][inner].blockView.textFieldValue2!
                }
                else {
                    content += "' value2='nil"
                }
                if blocks[outer][inner].blockView.textFieldValue3 != nil{
                    content += "' value3='" + blocks[outer][inner].blockView.textFieldValue3!
                }
                else {
                    content += "' value3='nil"
                }
                
                content += "' x='" + String(blocks[outer][inner].x)
                content += "' y='" + String(blocks[outer][inner].y) + "'></block>"
                array = "false"
            }
            array = "true"
        }
        content += "</sprite>"
        return content
    }
}