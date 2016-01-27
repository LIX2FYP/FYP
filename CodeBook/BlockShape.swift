//
//  BlockShape.swift
//  CodeBook
//
//  Created by Joey Cheng on 13/1/2016.
//  Copyright © 2016 FYP. All rights reserved.
//

import Foundation
import UIKit

class BlockShape: UIView, UITextFieldDelegate{
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
    
    //label
    var label: UILabel?
    var label2: UILabel?
    var label3: UILabel?
    
    //textField
    var textField: UITextField?
    var textField2: UITextField?
    var textField3: UITextField?
    
    //value
    var textFieldValue: String?
    var textFieldValue2: String?
    var textFieldValue3: String?
    
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
            
            if type == "motion"{
                if id == 12{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "x position")
                    self.addSubview(label!)
                }
                else if id == 13{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "y position")
                    self.addSubview(label!)
                }
                else if id == 14{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "direction")
                    self.addSubview(label!)
                }
            }
            case "cmd": drawCmdShape()
            
            if type == "motion"{
                if id == 0{
                    
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "move")
                    self.addSubview(label!)
                    
                    textField = createTextField(50, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                    
                    label2 = createLabel(85, y: 10, width: 60, height: 15, text: "step")
                    self.addSubview(label2!)
                }
                else if id == 1{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "turn right")
                    self.addSubview(label!)
                    
                    textField = createTextField(50, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                    
                    label2 = createLabel(85, y: 10, width: 60, height: 15, text: "degrees")
                    self.addSubview(label2!)
                }
                else if id == 2{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "turn left")
                    self.addSubview(label!)
                    
                    textField = createTextField(50, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                    
                    label2 = createLabel(85, y: 10, width: 60, height: 15, text: "degrees")
                    self.addSubview(label2!)
                }
                else if id == 3{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "point in direction")
                    self.addSubview(label!)
                    
                    textField = createTextField(80, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                }
                else if id == 4{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "go to x:")
                    self.addSubview(label!)
                    
                    textField = createTextField(50, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                    
                    label2 = createLabel(85, y: 10, width: 60, height: 15, text: "y:")
                    self.addSubview(label2!)
                    
                    textField2 = createTextField(90, y: 8, width: 30, height: 20, text: textFieldValue2!)
                    self.addSubview(textField2!)
                }
                else if id == 5{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "glide")
                    self.addSubview(label!)
                    
                    textField = createTextField(20, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                    
                    label2 = createLabel(35, y: 10, width: 60, height: 15, text: "secs to x:")
                    self.addSubview(label2!)
                    
                    textField2 = createTextField(50, y: 8, width: 30, height: 20, text: textFieldValue2!)
                    self.addSubview(textField2!)
                    
                    label3 = createLabel(65, y: 10, width: 60, height: 15, text: "y:")
                    self.addSubview(label3!)
                    
                    textField3 = createTextField(80, y: 8, width: 30, height: 20, text: textFieldValue3!)
                    self.addSubview(textField3!)
                }
                else if id == 6{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "change x by")
                    self.addSubview(label!)
                    
                    textField = createTextField(20, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                }
                else if id == 7{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "set x to")
                    self.addSubview(label!)
                    
                    textField = createTextField(20, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                }
                else if id == 8{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "change y by")
                    self.addSubview(label!)
                    
                    textField = createTextField(20, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                }
                else if id == 9{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "set y to")
                    self.addSubview(label!)
                    
                    textField = createTextField(20, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                }
                else if id == 10{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "if on edge, bounce")
                    self.addSubview(label!)
                }
                else if id == 11{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "set rotation style")
                    self.addSubview(label!)
                }
            }
            else if type == "looks"{
                if id == 0{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "say")
                    self.addSubview(label!)
                    
                    textField = createTextField(20, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                    
                    label2 = createLabel(35, y: 10, width: 60, height: 15, text: "for")
                    self.addSubview(label2!)
                    
                    textField2 = createTextField(50, y: 8, width: 30, height: 20, text: textFieldValue2!)
                    self.addSubview(textField2!)
                    
                    label3 = createLabel(80, y: 10, width: 60, height: 15, text: "secs")
                    self.addSubview(label3!)
                }
                else if id == 1{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "say")
                    self.addSubview(label!)
                    
                    textField = createTextField(20, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                }
                else if id == 2{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "think")
                    self.addSubview(label!)
                    
                    textField = createTextField(20, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                    
                    label2 = createLabel(35, y: 10, width: 60, height: 15, text: "for")
                    self.addSubview(label2!)
                    
                    textField2 = createTextField(50, y: 8, width: 30, height: 20, text: textFieldValue2!)
                    self.addSubview(textField2!)
                    
                    label3 = createLabel(80, y: 10, width: 60, height: 15, text: "secs")
                    self.addSubview(label3!)
                }
                else if id == 3{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "think")
                    self.addSubview(label!)
                    
                    textField = createTextField(20, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                }
                else if id == 4{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "show")
                    self.addSubview(label!)
                }
                else if id == 5{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "hide")
                    self.addSubview(label!)
                }
                else if id == 6{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "switch costume to")
                    self.addSubview(label!)
                }
                else if id == 7{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "next costume")
                    self.addSubview(label!)
                }
                else if id == 8{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "change size by")
                    self.addSubview(label!)
                    
                    textField = createTextField(20, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                }
                else if id == 9{
                    label = createLabel(5, y: 10, width: 60, height: 15, text: "set size to")
                    self.addSubview(label!)
                    
                    textField = createTextField(20, y: 8, width: 30, height: 20, text: textFieldValue!)
                    self.addSubview(textField!)
                    
                    label2 = createLabel(35, y: 10, width: 60, height: 15, text: "%")
                    self.addSubview(label2!)
                }
            }
            case "ifelse": drawIfElseShape()
            case "loop": drawLoopShape()
            case "cmdoutline": drawCmdOutlineShape()
            case "finalCmdShape": drawCmdShape()
            case "loopShape": drawLoopShape()
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
        drawRightAndBottom(topH!, hasNotch: (shape != "finalCmdShape"))
    }
    
    func drawCmdOutlineShape(){
        g.lineWidth = 2
        UIColor(red: 0, green: 1, blue: 1, alpha: 0.2).setStroke()
        drawTop()
        drawRightAndBottom(topH!, hasNotch: (shape != "finalCmdShape"))
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
        drawRightAndBottom(h1 + BottomBarH, hasNotch: (shape == "loopShape"))
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
    
    func createLabel (x: CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, text:String) -> UILabel{
        var newLabel = UILabel(frame: CGRectMake(x, y, width, height))
        newLabel.textColor = UIColor.whiteColor()
        newLabel.textAlignment = NSTextAlignment.Left
        newLabel.text = text
        return newLabel
    }
    
    func createTextField (x: CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, text:String) -> UITextField{
        var newTextField = UITextField(frame: CGRect(x: x, y: y, width: width, height: height))
        newTextField.backgroundColor = UIColor.whiteColor()
        newTextField.layer.cornerRadius = 10
        newTextField.textAlignment = NSTextAlignment.Center
        newTextField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        newTextField.delegate = self
        newTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        newTextField.text = text
        return newTextField
    }
    
    func textFieldDidChange(changedTextField: UITextField){
        if changedTextField.isEqual(textField){
            textFieldValue = changedTextField.text
        }
        else if changedTextField.isEqual(textField2){
            textFieldValue2 = changedTextField.text
        }
        else if changedTextField.isEqual(textField3){
            textFieldValue3 = changedTextField.text
        }
        

    }
    
}