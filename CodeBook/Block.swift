//
//  Block.swift
//  CodeBook
//
//  Created by Joey Cheng on 12/1/2016.
//  Copyright © 2016 FYP. All rights reserved.
//

import Foundation
import UIKit

class Block{
    var type: String
    var id: Int
    var x: CGFloat
    var y: CGFloat
    
    var textFieldValue: String
    var textFieldValue2: String
    var textFieldValue3: String
    
    var innerBlock1: Block?
    var innerBlock2: Block?
    var innerBlock3: Block?
    
    var upperBlockArray: Array<Block> = []
    var lowerBlockArray: Array<Block> = []

    //
    var blockView: BlockShape!
    var size: CGSize!
    var shape: String
    
    init(type: String, id: Int, shape: String, x: CGFloat, y: CGFloat, textFieldValue: String, textFieldValue2: String, textFieldValue3: String){
        self.type = type
        self.id = id
        self.shape = shape
        //self.value = value
        //self.value2 = value2
        self.x = x
        self.y = y
        self.textFieldValue = textFieldValue
        self.textFieldValue2 = textFieldValue2
        self.textFieldValue3 = textFieldValue3
        
        if shape == "prochat" || shape == "ifelse" {
            self.size = CGSize(width: 120, height: 200) // *5
        }
        else if shape == "loop" {
            self.size = CGSize(width: 120, height: 120) // *3
        }
        else {
            self.size = CGSize(width: 120, height: 40)
        }
        
        createBlock()
    }
    
    func createBlock(){
        blockView = BlockShape()
        blockView.type = type
        blockView.id = id
        blockView.shape = shape
        
        blockView.textFieldValue = textFieldValue
        blockView.textFieldValue2 = textFieldValue2
        blockView.textFieldValue3 = textFieldValue3
       
        blockView.center.x = x
        blockView.center.y = y
        blockView.frame.size.width = size.width
        blockView.frame.size.height = size.height
        
        blockView.userInteractionEnabled = true
        
    }
    
    
    func runBlock(sprite: Sprite){
        if type == "motion"{
            //move
            if id == 0 {
                dispatch_async(dispatch_get_main_queue()) {
                    if sprite.spriteImageView.center.x + CGFloat(Float(self.blockView.textFieldValue!)!) * sin(sprite.rotation * CGFloat(M_PI / 180)) > 700{
                        sprite.spriteImageView.center.x = 700
                    }
                    else if sprite.spriteImageView.center.x + CGFloat(Float(self.blockView.textFieldValue!)!) * sin(sprite.rotation * CGFloat(M_PI / 180)) < 0{
                        sprite.spriteImageView.center.x = 0
                    }
                    else {
                        sprite.spriteImageView.center.x += CGFloat(Float(self.blockView.textFieldValue!)!) * sin(sprite.rotation * CGFloat(M_PI / 180))
                    }
                    
                    if sprite.spriteImageView.center.y + CGFloat(Float(self.blockView.textFieldValue!)!) * -cos(sprite.rotation * CGFloat(M_PI / 180)) > 400 {
                        sprite.spriteImageView.center.y = 400
                    }
                    else if sprite.spriteImageView.center.y + CGFloat(Float(self.blockView.textFieldValue!)!) * -cos(sprite.rotation * CGFloat(M_PI / 180)) < 0 {
                        sprite.spriteImageView.center.y = 0
                    }
                    else {
                        sprite.spriteImageView.center.y += CGFloat(Float(self.blockView.textFieldValue!)!) * -cos(sprite.rotation * CGFloat(M_PI / 180))
                    }
                    
                    sprite.x = sprite.spriteImageView.center.x
                    sprite.y = sprite.spriteImageView.center.y
                    
                    sprite.talkingView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
                    sprite.talkingView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
                }
            }
                //trun +
            else if id == 1 {
                dispatch_async(dispatch_get_main_queue()) {
                    if sprite.rotationStyle == 0 {
                        if sprite.rotation % 360 <= 180{
                            sprite.spriteImageView.transform = CGAffineTransformMakeRotation(0)
                        }
                        else {
                            sprite.spriteImageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
                        }
                        
                    }
                    else if sprite.rotationStyle == 1 {
                        sprite.spriteImageView.transform = CGAffineTransformMakeRotation(0)
                    }
                    else {
                        sprite.spriteImageView.transform = CGAffineTransformMakeRotation(((sprite.rotation - 90) + CGFloat(Float(self.blockView.textFieldValue!)!)) * CGFloat(M_PI / 180))
                    }
                    sprite.rotation += CGFloat(Float(self.blockView.textFieldValue!)!)
                    sprite.rotation %= 360
                }
            }
                //turn -
            else if id == 2 {
                dispatch_async(dispatch_get_main_queue()) {
                    if sprite.rotationStyle == 0 {
                        if sprite.rotation % 360 <= 180{
                            sprite.spriteImageView.transform = CGAffineTransformMakeRotation(0)
                        }
                        else {
                            sprite.spriteImageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
                        }
                        
                    }
                    else if sprite.rotationStyle == 1 {
                        sprite.spriteImageView.transform = CGAffineTransformMakeRotation(0)
                    }
                    else {
                        sprite.spriteImageView.transform = CGAffineTransformMakeRotation(((sprite.rotation - 90) - CGFloat(Float(self.blockView.textFieldValue!)!)) * CGFloat(M_PI / 180))
                    }
                    sprite.rotation -= CGFloat(Float(self.blockView.textFieldValue!)!)
                    sprite.rotation %= 360
                }
            }
                //point in direction
            else if id == 3 {
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.spriteImageView.transform = CGAffineTransformMakeRotation(CGFloat(Float(self.blockView.textFieldValue!)!) * CGFloat(M_PI / 180))
                    sprite.rotation = CGFloat(Float(self.blockView.textFieldValue!)!)
                }
            }
                // go to x y
            else if id == 4 {
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.spriteImageView.center.x = CGFloat(Float(self.blockView.textFieldValue!)!)
                    sprite.spriteImageView.center.y = CGFloat(Float(self.blockView.textFieldValue2!)!)
                    sprite.x = CGFloat(Float(self.blockView.textFieldValue!)!)
                    sprite.y = CGFloat(Float(self.blockView.textFieldValue2!)!)
                    
                    sprite.talkingView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
                    sprite.talkingView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
                }
            }
                // use x sec go to x y
            else if id == 5 {
                //animate
                dispatch_async(dispatch_get_main_queue()) {
                    UIView.animateWithDuration(Double(self.blockView.textFieldValue!)!){
                        sprite.spriteImageView.center.x = CGFloat(Float(self.blockView.textFieldValue2!)!)
                        sprite.spriteImageView.center.y = CGFloat(Float(self.blockView.textFieldValue3!)!)
                        sprite.x = CGFloat(Float(self.blockView.textFieldValue2!)!)
                        sprite.y = CGFloat(Float(self.blockView.textFieldValue3!)!)
                        
                        sprite.talkingView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
                        sprite.talkingView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
                    }
                }
                doNothing(Double(blockView.textFieldValue!)!)
            }
                // change x by x
            else if id == 6 {
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.spriteImageView.center.x += CGFloat(Float(self.blockView.textFieldValue!)!)
                    sprite.x += CGFloat(Float(self.blockView.textFieldValue!)!)
                    
                    sprite.talkingView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
                }
            }
                // set x by x
            else if id == 7 {
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.spriteImageView.center.x = CGFloat(Float(self.blockView.textFieldValue!)!)
                    sprite.x = CGFloat(Float(self.blockView.textFieldValue!)!)
                    
                    sprite.talkingView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
                }
            }
                //change y by x
            else if id == 8 {
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.spriteImageView.center.y += CGFloat(Float(self.blockView.textFieldValue!)!)
                    sprite.y += CGFloat(Float(self.blockView.textFieldValue!)!)
                    
                    sprite.talkingView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
                }
            }
                //set y by x
            else if id == 9 {
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.spriteImageView.center.y = CGFloat(Float(self.blockView.textFieldValue!)!)
                    sprite.y = CGFloat(Float(self.blockView.textFieldValue!)!)
                    
                    sprite.talkingView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
                }
            }
                //bounce
            else if id == 10{
                dispatch_async(dispatch_get_main_queue()) {
                    if sprite.spriteImageView.frame.origin.x <= 0 ||  sprite.spriteImageView.frame.origin.x + sprite.spriteImageView.image!.size.width >= 700{
                        sprite.rotation *= -1
                        sprite.spriteImageView.transform = CGAffineTransformMakeRotation((sprite.rotation - 90) * CGFloat(M_PI / 180))
                    }
                    if sprite.spriteImageView.frame.origin.y <= 0 || sprite.spriteImageView.frame.origin.y + sprite.spriteImageView.image!.size.height >= 400 {
                        sprite.rotation = 180 - sprite.rotation
                        sprite.spriteImageView.transform = CGAffineTransformMakeRotation((sprite.rotation - 90) * CGFloat(M_PI / 180))
                    }
                }
            }
                //set rotation style
            else if id == 11 {
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.rotationStyle = Int(self.blockView.textFieldValue!)!
                }
            }
            //get x
            else if id == 12 {
                
            }
            //get y
            else if id == 13 {
                
            }
            //get rotation
            else if id == 14{
                
            }
            
        }
        else if type == "events" {
        }
        else if type == "looks" {
            //say hello for 2 sec
            if id == 0 {
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.talkingView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
                    sprite.talkingView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
                    sprite.talkingImageView.image = UIImage(named: "box_say")!
                    
                    sprite.talkingLabel.text = self.blockView.textFieldValue
                    sprite.talkingLabel.textColor = UIColor.blackColor()
                    sprite.talkingLabel.textAlignment = NSTextAlignment.Center
                    sprite.talkingView.hidden = false
                }
                
                doNothing(Double(blockView.textFieldValue2!)!)
                
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.talkingView.hidden = true
                }
            }
                //say hello
            else if id == 1 {
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.talkingView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
                    sprite.talkingView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
                    sprite.talkingImageView.image = UIImage(named: "box_say")!
                    
                    sprite.talkingLabel.text = self.blockView.textFieldValue
                    sprite.talkingLabel.textColor = UIColor.blackColor()
                    sprite.talkingLabel.textAlignment = NSTextAlignment.Center
                    sprite.talkingView.hidden = false
                }
            }
                //think hum for 2 sec
            else if id == 2 {
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.talkingView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
                    sprite.talkingView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
                    sprite.talkingImageView.image = UIImage(named: "box_think")!
                    
                    sprite.talkingLabel.text = self.blockView.textFieldValue
                    sprite.talkingLabel.textColor = UIColor.blackColor()
                    sprite.talkingLabel.textAlignment = NSTextAlignment.Center
                    sprite.talkingView.hidden = false
                }
                
                doNothing(Double(blockView.textFieldValue2!)!)
                
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.talkingView.hidden = true
                }
            }
                //think hum
            else if id == 3 {
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.talkingView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
                    sprite.talkingView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
                    sprite.talkingImageView.image = UIImage(named: "box_think")!
                    
                    sprite.talkingLabel.text = self.blockView.textFieldValue
                    sprite.talkingLabel.textColor = UIColor.blackColor()
                    sprite.talkingLabel.textAlignment = NSTextAlignment.Center
                    sprite.talkingView.hidden = false
                }
            }
                //show
            else if id == 4 {
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.spriteImageView.hidden = false
                }
            }
                //hide
            else if id == 5 {
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.spriteImageView.hidden = true
                }
            }
                //switch costume
            else if id == 6{
                
            }
                //next costume
            else if id == 7{
                dispatch_async(dispatch_get_main_queue()) {
                    
                    var ratio: CGFloat = sprite.height / sprite.costume[sprite.currentCostume].size.height
                    
                    if sprite.currentCostume + 1 < sprite.costume.endIndex{
                        sprite.currentCostume++
                    }
                    else {
                        sprite.currentCostume = 0
                    }
                    
                    sprite.spriteImageView.transform = CGAffineTransformMakeRotation(0)
                    
                    sprite.spriteImageView.image = sprite.costume[sprite.currentCostume]
                    sprite.spriteImageView.frame.size.height = sprite.spriteImageView.image!.size.height * ratio
                    sprite.spriteImageView.frame.size.width = sprite.spriteImageView.image!.size.width * ratio
                    sprite.height = sprite.spriteImageView.frame.size.height
                    sprite.width = sprite.spriteImageView.frame.size.width
                    
                    sprite.spriteImageView.transform = CGAffineTransformMakeRotation((sprite.rotation - 90) * CGFloat(M_PI / 180))
                }
            }
                //change size by x
            else if id == 8 {
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.spriteImageView.transform = CGAffineTransformMakeRotation(0)
                    
                    sprite.spriteImageView.frame.size.height *= (1 + CGFloat(Float(self.blockView.textFieldValue!)!) / 100)
                    sprite.spriteImageView.frame.size.width *= (1 + CGFloat(Float(self.blockView.textFieldValue!)!) / 100)
                    sprite.spriteImageView.center.x = sprite.x
                    sprite.spriteImageView.center.y = sprite.y
                    sprite.height = sprite.spriteImageView.frame.size.height
                    sprite.width = sprite.spriteImageView.frame.size.width
                    
                    sprite.spriteImageView.transform = CGAffineTransformMakeRotation((sprite.rotation - 90) * CGFloat(M_PI / 180))
                }
            }
                //set size to x
            else if id == 9{
                dispatch_async(dispatch_get_main_queue()) {
                    sprite.spriteImageView.transform = CGAffineTransformMakeRotation(0)
                    
                    sprite.spriteImageView.frame.size.height = sprite.spriteImageView.image!.size.height * (CGFloat(Float(self.blockView.textFieldValue!)!) / 100)
                    sprite.spriteImageView.frame.size.width = sprite.spriteImageView.image!.size.width * (CGFloat(Float(self.blockView.textFieldValue!)!) / 100)
                    sprite.height = sprite.spriteImageView.frame.size.height
                    sprite.width = sprite.spriteImageView.frame.size.width
                    
                    sprite.spriteImageView.transform = CGAffineTransformMakeRotation((sprite.rotation - 90) * CGFloat(M_PI / 180))
                }
            }
        }
        else if type == "control" {
            //wait x sec
            if id == 0 {
                doNothing(Double(blockView.textFieldValue!)!)
            }
                //repeat x
            else if id == 1{
                dispatch_async(dispatch_get_main_queue()) {
                    for loopTime in 0 ... Int(self.blockView.textFieldValue!)!{
                        for upperBlock in self.upperBlockArray{
                            upperBlock.runBlock(sprite)
                        }
                    }
                }
            }
                //forever
            else if id == 2{
                dispatch_async(dispatch_get_main_queue()) {
                    while true{
                        for upperBlock in self.upperBlockArray{
                            upperBlock.runBlock(sprite)
                        }
                    }
                }
            }
                //if true
            else if id == 3{
                dispatch_async(dispatch_get_main_queue()) {
                    if true{
                        for upperBlock in self.upperBlockArray{
                            upperBlock.runBlock(sprite)
                        }
                    }
                }
            }
                //if else
            else if id == 4{
                dispatch_async(dispatch_get_main_queue()) {
                    if true{
                        for upperBlock in self.upperBlockArray{
                            upperBlock.runBlock(sprite)
                        }
                    }
                    else {
                        for lowerBlock in self.lowerBlockArray{
                            lowerBlock.runBlock(sprite)
                        }
                    }
                }
            }
                //wait until
            else if id == 5{
                while true{
                    if true{
                        break
                    }
                }
            }
                //repeat until
            else if id == 6{
                dispatch_async(dispatch_get_main_queue()) {
                    while true{
                        for upperBlock in self.upperBlockArray{
                            upperBlock.runBlock(sprite)
                        }
                    }
                }
            }
                //stop all
            else if id == 7{
                
            }
        }
        else if type == "sound" {
        }
        else if type == "sensing" {
            
        }
        else if type == "operator" {
            
        }
    }
    
    func doNothing(delay: Double){
        NSThread.sleepForTimeInterval(delay)
    }
}