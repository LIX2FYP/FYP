//
//  BlockShape.swift
//  CodeBook
//
//  Created by Joey Cheng on 13/1/2016.
//  Copyright © 2016 FYP. All rights reserved.
//

import Foundation
import UIKit

class BlockShape: UIView{
    //graphic
    var g = UIBezierPath()
    //width
    var w: CGFloat?
    var topH: CGFloat?
    var type: String!
    var id: Int!
    var shape: String!
    var size = CGSize(width: 120, height: 40)
    
    //Geometry
    let NotchDepth: CGFloat = 3
    let EmptySubstackH: CGFloat = 12
    let SubstackInset: CGFloat = 15
    
    let CornerInset: CGFloat = 3
    let InnerCornerInset: CGFloat = 2
    let BottomBarH: CGFloat = 16
    let DividerH: CGFloat = 18
    let NotchL1: CGFloat = 13
    var NotchL2: CGFloat?
    var NotchR1: CGFloat?
    var NotchR2: CGFloat?
    
    var hasLoopArrow: Bool?
    
    var substack1H: CGFloat?
    var substack2H: CGFloat?
    var redrawNeeded: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override func drawRect(rect: CGRect) {
        w = size.width
        topH = size.height - NotchDepth
        NotchL2 = NotchL1 + NotchDepth
        NotchR1 = NotchL2! + 8
        NotchR2 = NotchR1! + NotchDepth
        substack1H = EmptySubstackH
        substack2H = EmptySubstackH
        
        //var label = UILabel(frame: CGRectMake(10, 15, 60, 20))
        //label.textColor = UIColor.whiteColor()
        //label.textAlignment = NSTextAlignment.Left
        
        //UIColor.orangeColor().setFill()
        if type == "motion"{
            UIColor.blueColor().setFill()
        }
        else if type == "events"{
            UIColor.brownColor().setFill()
        }
        else if type == "looks"{
            UIColor.purpleColor().setFill()
        }
        else if type == "control"{
            UIColor.orangeColor().setFill()
        }
        else if type == "sound"{
            UIColor.orangeColor().setFill()
        }
        else if type == "sensing"{
            UIColor.orangeColor().setFill()
        }
        else if type == "operator"{
            UIColor.orangeColor().setFill()
        }
        
        switch shape{
            case "hat": drawHatShape()
            
            //label.text = "Hat"
            //self.addSubview(label)
           // var text = UITextField(frame: CGRectMake(40, 15, 60, 20))
            //text.backgroundColor = UIColor.whiteColor()
            //text.layer.cornerRadius = CGFloat(5.0)
            //self.addSubview(text)
            
            case "rect": drawRectShape()
            
            //label.text = "Rect"
            //self.addSubview(label)
            
            //var text = UITextField(frame: CGRectMake(50, 15, 20, 20))
            //text.backgroundColor = UIColor.whiteColor()
            //text.layer.cornerRadius = CGFloat(10)
            //text.textAlignment = NSTextAlignment.Center
            //self.addSubview(text)
            
            case "bool": drawBoolShape()
            case "number": drawNumShape()
            case "cmd": drawCmdShape()
            case "ifelse": drawIfElseShape()
            case "loop": drawLoopShape()
            case "cmdoutline": drawCmdOutlineShape()
            default: break
        }
        
        g.fill()
        
    }
    
    func drawRectShape(){
        g = UIBezierPath(rect: CGRectMake(0, 0, w!, topH!))
    }
    
    func drawHatShape(){
        g.moveToPoint(CGPoint(x: 0, y: 12))
        curve(0, p1y: 12, p2x: 40, p2y: 0, roundness: 0.15)
        curve(40, p1y: 0, p2x: 80, p2y: 10, roundness: 0.12)
        g.addLineToPoint(CGPoint(x: w! - CornerInset, y: 10))
        g.addLineToPoint(CGPoint(x: w!, y: 10 + CornerInset))
        drawRightAndBottom(topH!, hasNotch: true)
    }
    
    func drawBoolShape(){
        var centerY: CGFloat = topH! / 2
        g.moveToPoint(CGPoint(x: centerY, y: topH!))
        g.addLineToPoint(CGPoint(x: 0, y: centerY))
        g.addLineToPoint(CGPoint(x: centerY, y: 0))
        g.addLineToPoint(CGPoint(x: w! - centerY, y: 0))
        g.addLineToPoint(CGPoint(x: w!, y: centerY))
        g.addLineToPoint(CGPoint(x: w! - centerY, y: topH!))
    }
    
    func drawNumShape(){
        var centerY: CGFloat = topH! / 2
        g.moveToPoint(CGPoint(x: centerY, y: topH!))
        curve(centerY, p1y: topH!, p2x: 0, p2y: centerY)
        curve(0, p1y: centerY, p2x: centerY, p2y: 0)
        g.addLineToPoint(CGPoint(x: w! - centerY, y: 0))
        curve(w! - centerY, p1y: 0, p2x: w!, p2y: centerY)
        curve(w!, p1y: centerY, p2x: w! - centerY, p2y: topH!)
    }
    
    func drawCmdShape(){
        drawTop()
        drawRightAndBottom(topH!, hasNotch: (shape != "FinalCmdShape"))
    }
    
    func drawCmdOutlineShape(){
        g.lineWidth = 2
        UIColor(red: 0, green: 1, blue: 1, alpha: 0.2).setStroke()
        drawTop()
        drawRightAndBottom(topH!, hasNotch: (shape != "FinalCmdShape"))
        g.addLineToPoint(CGPoint(x: 0, y: CornerInset))
    }
    
    func drawIfElseShape(){
        var h1: CGFloat = topH! + substack1H! - NotchDepth
        var h2: CGFloat = h1 + DividerH + substack2H! - NotchDepth
        drawTop()
        drawRightAndBottom(topH!, hasNotch: true, inset: SubstackInset)
        drawArm(h1)
        drawRightAndBottom(h1 + DividerH, hasNotch: true, inset: SubstackInset);
        drawArm(h2)
        drawRightAndBottom(h2 + BottomBarH, hasNotch: true)
    }
    
    func drawLoopShape(){
        var h1: CGFloat = topH! + substack1H! - NotchDepth
        drawTop()
        drawRightAndBottom(topH!, hasNotch: true, inset: SubstackInset)
        drawArm(h1)
        drawRightAndBottom(h1 + BottomBarH, hasNotch: (shape == "LoopShape"))
    }
    
    func drawArm(armTop: CGFloat){
        g.addLineToPoint(CGPoint(x: SubstackInset, y: armTop - InnerCornerInset))
        g.addLineToPoint(CGPoint(x: SubstackInset + InnerCornerInset, y: armTop))
        g.addLineToPoint(CGPoint(x: w! - CornerInset, y: armTop))
        g.addLineToPoint(CGPoint(x: w!, y: armTop + CornerInset))
    }
    
    func curve(p1x: CGFloat, p1y: CGFloat, p2x: CGFloat, p2y: CGFloat, roundness:CGFloat = 0.42){
        let midX: CGFloat = (p1x + p2x) / 2
        let midY: CGFloat = (p1y + p2y) / 2
        let cx: CGFloat = midX + (roundness * (p2y - p1y))
        let cy: CGFloat = midY - (roundness * (p2x - p1x))
        g.addQuadCurveToPoint(CGPoint(x: p2x, y: p2y), controlPoint: CGPoint(x: cx, y: cy))
    }
    
    func drawTop(){
        g.moveToPoint(CGPoint(x: 0, y: CornerInset))
        g.addLineToPoint(CGPoint(x: CornerInset, y: 0))
        g.addLineToPoint(CGPoint(x: NotchL1, y: 0))
        g.addLineToPoint(CGPoint(x: NotchL2!, y: NotchDepth))
        g.addLineToPoint(CGPoint(x: NotchR1!, y: NotchDepth))
        g.addLineToPoint(CGPoint(x: NotchR2!, y: 0))
        g.addLineToPoint(CGPoint(x: w! - CornerInset, y: 0))
        g.addLineToPoint(CGPoint(x: w!, y: CornerInset))
    }
    
    func drawRightAndBottom(bottomY: CGFloat, hasNotch: Bool, inset: CGFloat = 0){
        g.addLineToPoint(CGPoint(x: w!, y: bottomY - CornerInset))
        g.addLineToPoint(CGPoint(x: w! - CornerInset, y: bottomY))
        
        if hasNotch {
            g.addLineToPoint(CGPoint(x: inset + NotchR2!, y: bottomY))
            g.addLineToPoint(CGPoint(x: inset + NotchR1!, y: bottomY + NotchDepth))
            g.addLineToPoint(CGPoint(x: inset + NotchL2!, y: bottomY + NotchDepth))
            g.addLineToPoint(CGPoint(x: inset + NotchL1, y: bottomY))
        }
        if inset > 0 {
            g.addLineToPoint(CGPoint(x: inset + InnerCornerInset, y: bottomY))
            g.addLineToPoint(CGPoint(x: inset, y: bottomY + InnerCornerInset))
        }
        else {
            g.addLineToPoint(CGPoint(x: inset + CornerInset, y: bottomY))
            g.addLineToPoint(CGPoint(x: 0, y: bottomY - CornerInset))
        }
    }
    
}