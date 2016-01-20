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
    var value: String
    var value2: String
    var x: CGFloat
    var y: CGFloat

    //
    var blockView: BlockShape!
    var size: CGSize!
    var shape: String
    
    init(type: String, id: Int, shape: String, value: String, value2: String, x: CGFloat, y: CGFloat){
        self.type = type
        self.id = id
        self.shape = shape
        self.value = value
        self.value2 = value2
        self.x = x
        self.y = y
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
                if sprite.spriteImageView.center.x + CGFloat(Float(value)!) * sin(sprite.rotation * CGFloat(M_PI / 180)) > 700{
                    sprite.spriteImageView.center.x = 700
                }
                else if sprite.spriteImageView.center.x + CGFloat(Float(value)!) * sin(sprite.rotation * CGFloat(M_PI / 180)) < 0{
                    sprite.spriteImageView.center.x = 0
                }
                else {
                    sprite.spriteImageView.center.x += CGFloat(Float(value)!) * sin(sprite.rotation * CGFloat(M_PI / 180))
                }
                
                if sprite.spriteImageView.center.y + CGFloat(Float(value)!) * -cos(sprite.rotation * CGFloat(M_PI / 180)) > 400 {
                    sprite.spriteImageView.center.y = 400
                }
                else if sprite.spriteImageView.center.y + CGFloat(Float(value)!) * -cos(sprite.rotation * CGFloat(M_PI / 180)) < 0 {
                    sprite.spriteImageView.center.y = 0
                }
                else {
                    sprite.spriteImageView.center.y += CGFloat(Float(value)!) * -cos(sprite.rotation * CGFloat(M_PI / 180))
                }
                
                sprite.x = sprite.spriteImageView.center.x
                sprite.y = sprite.spriteImageView.center.y
                
                sprite.talkingImageView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
                sprite.talkingImageView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
            }
                //trun +
            else if id == 1 {
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
                    sprite.spriteImageView.transform = CGAffineTransformMakeRotation(((sprite.rotation - 90) + CGFloat(Float(value)!)) * CGFloat(M_PI / 180))
                }
                sprite.rotation += CGFloat(Float(value)!)
                sprite.rotation %= 360
            }
                //turn -
            else if id == 2 {
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
                    sprite.spriteImageView.transform = CGAffineTransformMakeRotation(((sprite.rotation - 90) - CGFloat(Float(value)!)) * CGFloat(M_PI / 180))
                }
                sprite.rotation -= CGFloat(Float(value)!)
                sprite.rotation %= 360
            }
                //point in direction
            else if id == 3 {
                sprite.spriteImageView.transform = CGAffineTransformMakeRotation(CGFloat(Float(value)!) * CGFloat(M_PI / 180))
                sprite.rotation = CGFloat(Float(value)!)
            }
                // go to x y
            else if id == 4 {
                sprite.spriteImageView.center.x = CGFloat(Float(value)!)
                sprite.spriteImageView.center.y = CGFloat(Float(value2)!)
                sprite.x = CGFloat(Float(value)!)
                sprite.y = CGFloat(Float(value2)!)
                
                sprite.talkingImageView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
                sprite.talkingImageView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
            }
                // use x sec go to x y
            else if id == 5 {
                //animate
            }
                // change x by x
            else if id == 6 {
                sprite.spriteImageView.center.x += CGFloat(Float(value)!)
                sprite.x += CGFloat(Float(value)!)
                
                sprite.talkingImageView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
            }
                // set x by x
            else if id == 7 {
                sprite.spriteImageView.center.x = CGFloat(Float(value)!)
                sprite.x = CGFloat(Float(value)!)
                
                sprite.talkingImageView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
            }
                //change y by x
            else if id == 8 {
                sprite.spriteImageView.center.y += CGFloat(Float(value)!)
                sprite.y += CGFloat(Float(value)!)
                
                sprite.talkingImageView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
            }
                //set y by x
            else if id == 9 {
                sprite.spriteImageView.center.y = CGFloat(Float(value)!)
                sprite.y = CGFloat(Float(value)!)
                
                sprite.talkingImageView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
            }
                //bounce
            else if id == 10{
                if sprite.spriteImageView.frame.origin.x <= 0 ||  sprite.spriteImageView.frame.origin.x + sprite.spriteImageView.image!.size.width >= 700{
                    sprite.rotation *= -1
                    sprite.spriteImageView.transform = CGAffineTransformMakeRotation((sprite.rotation - 90) * CGFloat(M_PI / 180))
                }
                if sprite.spriteImageView.frame.origin.y <= 0 || sprite.spriteImageView.frame.origin.y + sprite.spriteImageView.image!.size.height >= 400 {
                    sprite.rotation = 180 - sprite.rotation
                    sprite.spriteImageView.transform = CGAffineTransformMakeRotation((sprite.rotation - 90) * CGFloat(M_PI / 180))
                    
                }
            }
                //set rotation style
            else if id == 11 {
                sprite.rotationStyle = Int(value)!
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
                sprite.talkingImageView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
                sprite.talkingImageView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
                sprite.talkingImageView.image = UIImage(named: "box_say")!
                sprite.talkingImageView.hidden = false
                delay(UInt32(value)!){
                    sprite.talkingImageView.hidden = true
                }
                
                
            }
                //say hello
            else if id == 1 {
                sprite.talkingImageView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
                sprite.talkingImageView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
                sprite.talkingImageView.image = UIImage(named: "box_say")!
                sprite.talkingImageView.hidden = false
            }
                //think hum for 2 sec
            else if id == 2 {
                
            }
                //think hum
            else if id == 3 {
                sprite.talkingImageView.center.x = sprite.spriteImageView.center.x + sprite.spriteImageView.image!.size.width
                sprite.talkingImageView.center.y = sprite.spriteImageView.center.y - sprite.spriteImageView.image!.size.height/1.3
                sprite.talkingImageView.image = UIImage(named: "box_think")!
                sprite.talkingImageView.hidden = false
            }
                //show
            else if id == 4 {
                sprite.spriteImageView.hidden = false
            }
                //hide
            else if id == 5 {
                sprite.spriteImageView.hidden = true
            }
                //change size by x
            else if id == 6 {
                sprite.spriteImageView.frame.size.height *= (1 + CGFloat(Float(value)!) / 100)
                sprite.spriteImageView.frame.size.width *= (1 + CGFloat(Float(value)!) / 100)
                sprite.spriteImageView.center = sprite.spriteImageView.center
                sprite.height = sprite.spriteImageView.frame.size.height
                sprite.width = sprite.spriteImageView.frame.size.width
            }
                //set size to x
            else if id == 7{
                sprite.spriteImageView.frame.size.height = sprite.spriteImageView.image!.size.height * (CGFloat(Float(value)!) / 100)
                sprite.spriteImageView.frame.size.width = sprite.spriteImageView.image!.size.width * (CGFloat(Float(value)!) / 100)
                sprite.height = sprite.spriteImageView.frame.size.height
                sprite.width = sprite.spriteImageView.frame.size.width
            }
        }
        else if type == "control" {
            //wait x sec
            if id == 0 {
            }
        }
        else if type == "sound" {
        }
        else if type == "sensing" {
            
        }
        else if type == "operator" {
            
        }
    }
    
    func delay(delay:UInt32, closure:()->()) {
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW, Int64(Double(delay) * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
}