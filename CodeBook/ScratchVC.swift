//
//  ViewController.swift
//  CodeBook
//
//  Created by Joey Cheng on 12/1/2016.
//  Copyright © 2016 FYP. All rights reserved.
//

import UIKit
import Foundation

class ScratchVC: UIViewController, NSXMLParserDelegate {
    
    //View
    //MainView
    @IBOutlet weak var ScratchView: UIView!
    @IBOutlet weak var BlurView: UIView!
    //Scratch View
    @IBOutlet weak var StageView: UIView!
    @IBOutlet weak var SpriteSelectingAreaView: UIView!
    @IBOutlet weak var CodingBlockSelectionAreaView: UIView!
    @IBOutlet weak var CodingAreaView: UIView!
    
    //Add Sprite View
    @IBOutlet weak var AddSpriteView: UIView!
    @IBOutlet weak var SpriteLibrary: UIImageView!
    @IBOutlet weak var AddSpriteScroll: UIScrollView!
    @IBOutlet weak var OKBtn: UIButton!
    @IBOutlet weak var CancelBtn: UIButton!
    
    //Delete Sprite View
    @IBOutlet weak var DeleteSpriteView: UIView!
    @IBOutlet weak var DeleteSpriteImageView: UIImageView!
    @IBOutlet weak var YesBtn: UIButton!
    @IBOutlet weak var NoBtn: UIButton!
    
    //Add Background View
    @IBOutlet weak var AddBackgroundView: UIView!
    @IBOutlet weak var BackgroundLibrary: UIImageView!
    @IBOutlet weak var AddBackgroundScroll: UIScrollView!
    @IBOutlet weak var BgOKBtn: UIButton!
    @IBOutlet weak var BgCancelBtn: UIButton!
    
    //Scroll View
    @IBOutlet weak var SpriteSelectingScroll: UIScrollView!
    @IBOutlet weak var CodingBlockSelectionScroll: UIScrollView!
    @IBOutlet weak var CodingAreaScroll: UIScrollView!
    
    //Button
    //Scratch View
    @IBOutlet weak var PerviousBtn: UIButton!
    @IBOutlet weak var FlagBtn: UIButton!
    @IBOutlet weak var GridBtn: UIButton!
    @IBOutlet weak var HintBtn: UIButton!
    @IBOutlet weak var GuideBtn: UIButton!
    //Sprite SelectingArea View
    @IBOutlet weak var SpriteBtn: UIButton!
    @IBOutlet weak var BackgroundBtn: UIButton!
    //Coding Block Selection View
    @IBOutlet weak var MotionBtn: UIButton!
    @IBOutlet weak var EventsBtn: UIButton!
    @IBOutlet weak var LooksBtn: UIButton!
    @IBOutlet weak var ControlBtn: UIButton!
    @IBOutlet weak var SoundBtn: UIButton!
    @IBOutlet weak var SensingBtn: UIButton!
    @IBOutlet weak var OperatorsBtn: UIButton!
    
    //Label
    @IBOutlet weak var ProjectNameLabel: UILabel!
    
    //Image View
    @IBOutlet weak var GridImg: UIImageView!
    
    //XML
    var parser:NSXMLParser!
    //Sprite
    var parseringSprite: Sprite!
    //Block
    //xml 1d array
    var parseringBlocks: Array<Block> = []
    //xml 2d array
    var parseringArray: Array<Array<Block>> = []
    
    //var
    var projectName = ""
    //IO
    var docsPath: NSString!
    var filePath: String!
    //Add Sprite
    var selectedImage = ""
    var spriteNameArray: Array<String> = ["redbird", "turtle", "rabbit", "crow_standing", "pig_mum", "pig_first", "pig_second", "pig_third", "wolf", "boy", "sheep", "prince", "princess", "devil", "devil_blue"]
    var spriteLibraryArray: Array<UIImage> = []
    //Add Background
    var backgroundNameArray: Array<String> = ["bg_1basics", "bg_2sequencing", "bg_3.1sequencing", "bg_3.4sequencing", "bg_4.1conditionals", "bg_4.2conditionals", "bg_4.3conditionals", "bg_4.4conditionals", "bg_5function", "bg_6EmptyBackground", "bg_bgWithLevels"]
    var backgroundLibraryArray: Array<UIImage> = []
    //selection block
    var selectionBlocks: Array<Block> = []
    //background
    var background: String = ""
    //Sprite
    var sprites: Array<Sprite> = []
    var allSpriteBlocks: Array<Array<Array<Block>>> = []
    var selectedSpriteIndex: Int = 0
    //Sprite Icon
    var iconX:CGFloat = 20
    var selectedSpriteIconIndex = 0
    //touches moving
    var touchArea: UIView!
    var beganLocation: CGPoint!
    var relativePoint: CGPoint = CGPoint(x: 0, y: 0)
    //recognizer moving
    var selectedBlockArrayIndex: Int = 0
    var selectedBlockIndex: Int = 0
    var selectedView: UIView!
    var selectedBlockArea: UIView!
    var nearByArrayIndex: Int = 0
    var nearByBlockIndex: Int = 0
    var positionOfNearBy: String = ""
    //flat
    var running: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SpriteSelectingScroll.backgroundColor = UIColor.whiteColor()
        CodingBlockSelectionScroll.backgroundColor = UIColor.whiteColor()
        CodingAreaScroll.backgroundColor = UIColor.whiteColor()
        
        SpriteSelectingScroll.contentSize.width = 532
        
        CodingBlockSelectionScroll.contentSize.height = 310
        
        CodingAreaScroll.contentSize.width = 1000
        CodingAreaScroll.contentSize.height = 1000
        
        AddSpriteScroll.contentSize.height = 1050
        AddBackgroundScroll.contentSize.height = 880
        var x: CGFloat  = 150
        var y: CGFloat = 120
        
        for sprite in spriteNameArray{
            let spriteImage: UIImage = UIImage(named: sprite)!
            spriteLibraryArray.append(spriteImage)
            let spriteBtn = UIButton(type: UIButtonType.System) as UIButton
            spriteBtn.setBackgroundImage(spriteImage, forState: UIControlState.Normal)
            spriteBtn.frame.size.height = spriteImage.size.height
            spriteBtn.frame.size.width = spriteImage.size.width
            spriteBtn.center = CGPoint(x: x, y: y)
            spriteBtn.addTarget(self, action: "selectSprite:", forControlEvents: UIControlEvents.TouchUpInside)
            AddSpriteScroll.addSubview(spriteBtn)
            
            if x == 150 || x == 401{
                x += 251
            }
            else if x == 652 {
                x = 150
                y += 200
            }
        }
        
        x = 150
        y = 120
        for background in backgroundNameArray{
            let backgroundImage: UIImage = UIImage(named: background)!
            backgroundLibraryArray.append(backgroundImage)
            let backgroundBtn = UIButton(type: UIButtonType.System) as UIButton
            backgroundBtn.setBackgroundImage(backgroundImage, forState: UIControlState.Normal)
            backgroundBtn.frame.size.height = 114
            backgroundBtn.frame.size.width = 200
            backgroundBtn.center = CGPoint(x: x, y: y)
            backgroundBtn.addTarget(self, action: "selectBackground:", forControlEvents: UIControlEvents.TouchUpInside)
            AddBackgroundScroll.addSubview(backgroundBtn)
            
            if x == 150 || x == 400{
                x += 250
            }
            else if x == 650 {
                x = 150
                y += 214
            }
        }
        
        
        x = 20
        y = 20
        for index in 0 ... 37{
            var panBlock = UIPanGestureRecognizer(target: self, action: "moveBlock:")
            
            var textFieldValue: String = "nil"
            var textFieldValue2: String = "nil"
            var textFieldValue3: String = "nil"
            //motion
            if index < 12{
                if index == 0 || index == 6 || index == 8{
                    textFieldValue = "10"
                }
                else if index == 1 || index == 2{
                    textFieldValue = "15"
                }
                else if index == 3{
                    textFieldValue = "90"
                }
                else if index == 4{
                    textFieldValue = "0"
                    textFieldValue2 = "0"
                }
                else if index == 5{
                    textFieldValue = "1"
                    textFieldValue2 = "0"
                    textFieldValue3 = "0"
                }
                else if index == 7 || index == 9{
                    textFieldValue = "0"
                }
                selectionBlocks.append(Block(type: "motion", id: index, shape: "cmd", x: x, y: y, textFieldValue: textFieldValue, textFieldValue2: textFieldValue2, textFieldValue3: textFieldValue3))
            }
            else if index < 15{
                selectionBlocks.append(Block(type: "motion", id: index, shape: "number", x: x, y: y, textFieldValue: textFieldValue, textFieldValue2: textFieldValue2, textFieldValue3: textFieldValue3))
            }
                //events
            else if index < 17{
                if index == 15{
                    x = 20
                    y = 20
                }
                selectionBlocks.append(Block(type: "events", id: index - 15, shape: "hat", x: x, y: y, textFieldValue: textFieldValue, textFieldValue2: textFieldValue2, textFieldValue3: textFieldValue3))
                
            }
            else if index < 20{
                selectionBlocks.append(Block(type: "events", id: index - 15, shape: "cmd", x: x, y: y, textFieldValue: textFieldValue, textFieldValue2: textFieldValue2, textFieldValue3: textFieldValue3))
            }
                //looks
            else if index < 30{
                if index == 20{
                    x = 20
                    y = 20
                }
                if index - 20 == 0{
                    textFieldValue = "Hello!"
                    textFieldValue2 = "2"
                }
                else if index - 20 == 1{
                    textFieldValue = "Hello!"
                }
                else if index - 20 == 2{
                    textFieldValue = "Hmm..."
                    textFieldValue2 = "2"
                }
                else if index - 20 == 3{
                    textFieldValue = "Hmm..."
                }
                else if index - 20 == 8{
                    textFieldValue = "10"
                }
                else if index - 20 == 9{
                    textFieldValue = "100"
                }
                selectionBlocks.append(Block(type: "looks", id: index - 20, shape: "cmd", x: x, y: y, textFieldValue: textFieldValue, textFieldValue2: textFieldValue2, textFieldValue3: textFieldValue3))
            }
                //control
            else if index < 31{
                if index == 30{
                    x = 20
                    y = 20
                }
                if index - 30 == 0{
                    textFieldValue = "1"
                }
                selectionBlocks.append(Block(type: "control", id: index - 30, shape: "cmd", x: x, y: y, textFieldValue: textFieldValue, textFieldValue2: textFieldValue2, textFieldValue3: textFieldValue3))
            }
            else if index < 32{
                if index - 30 == 1{
                    textFieldValue = "10"
                }
                selectionBlocks.append(Block(type: "control", id: index - 30, shape: "loopShape", x: x, y: y, textFieldValue: textFieldValue, textFieldValue2: textFieldValue2, textFieldValue3: textFieldValue3))
                
            }
            else if index < 33{
                selectionBlocks.append(Block(type: "control", id: index - 30, shape: "loop", x: x, y: y, textFieldValue: textFieldValue, textFieldValue2: textFieldValue2, textFieldValue3: textFieldValue3))
            }
            else if index < 34{
                selectionBlocks.append(Block(type: "control", id: index - 30, shape: "loopShape", x: x, y: y, textFieldValue: textFieldValue, textFieldValue2: textFieldValue2, textFieldValue3: textFieldValue3))
            }
            else if index < 35{
                selectionBlocks.append(Block(type: "control", id: index - 30, shape: "ifelse", x: x, y: y, textFieldValue: textFieldValue, textFieldValue2: textFieldValue2, textFieldValue3: textFieldValue3))
                
            }
            else if index < 36{
                selectionBlocks.append(Block(type: "control", id: index - 30, shape: "cmd", x: x, y: y, textFieldValue: textFieldValue, textFieldValue2: textFieldValue2, textFieldValue3: textFieldValue3))
                
            }
            else if index < 37{
                selectionBlocks.append(Block(type: "control", id: index - 30, shape: "loopShape", x: x, y: y, textFieldValue: textFieldValue, textFieldValue2: textFieldValue2, textFieldValue3: textFieldValue3))
                
            }
            else if index < 38{
                selectionBlocks.append(Block(type: "control", id: index - 30, shape: "finalCmdShape", x: x, y: y, textFieldValue: textFieldValue, textFieldValue2: textFieldValue2, textFieldValue3: textFieldValue3))
            }
            selectionBlocks[index].blockView.addGestureRecognizer(panBlock)
            if index < 15{
                selectionBlocks[index].blockView.hidden = false
            }
            else{
                selectionBlocks[index].blockView.hidden = true
            }
            CodingBlockSelectionScroll.addSubview(selectionBlocks[index].blockView)
            
            if x == 20 || x == 170{
                x += 150
            }
            else if x == 320{
                x = 20
                y += 60
            }
        }
        
        GridImg.hidden = true
        BlurView.hidden = true
        AddSpriteView.hidden = true
        DeleteSpriteView.hidden = true
        AddBackgroundView.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        ProjectNameLabel.text = projectName
        
        sprites = []
        selectedSpriteIconIndex = 0
        iconX = 55
        
        docsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        filePath = docsPath.stringByAppendingPathComponent(projectName + ".xml")
        
        parser = NSXMLParser(contentsOfURL: NSURL(fileURLWithPath: filePath))
        print(filePath)
        parser.delegate = self
        parser.parse()
        
        //background
        if background != ""{
            let backgroundImage: UIImage = UIImage(named: background)!
            let backgroundImageView: UIImageView = UIImageView()
            
            backgroundImageView.image = backgroundImage
            backgroundImageView.frame = CGRect(x: -1, y: 0, width: backgroundImage.size.width, height: backgroundImage.size.height)
            StageView.addSubview(backgroundImageView)
            StageView.sendSubviewToBack(backgroundImageView)
        }
        
        for sprite in sprites{
            StageView.addSubview(sprite.spriteImageView)
            StageView.addSubview(UIView(frame: CGRectMake(sprite.spriteImageView.center.x, sprite.spriteImageView.center.y, 10, 10)))
            StageView.addSubview(sprite.talkingView)
            
            //block
            for spriteBlockArray in sprite.blocks{
                for spriteBlock in spriteBlockArray{
                    var panBlock = UIPanGestureRecognizer(target: self, action: "moveBlock:")
                    spriteBlock.blockView.addGestureRecognizer(panBlock)
                    CodingAreaScroll.addSubview(spriteBlock.blockView)
                }
            }
            
            //sprite icon
            sprite.spriteIconImageView.center.x = iconX
            iconX += 100
            
            //delete
            var longPressSprite = UILongPressGestureRecognizer(target: self, action: "deleteSprite:")
            sprite.spriteIconImageView.addGestureRecognizer(longPressSprite)
            SpriteSelectingScroll.addSubview(sprite.spriteIconImageView)
            
        }
        
        if sprites.count >= 6 {
            for index in 0...(sprites.count-6){
                SpriteSelectingScroll.contentSize.width += 100
            }
        }
        showSelectedSpriteBlocks()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            var location = touch.locationInView(ScratchView)
            
            if StageView.frame.contains(location){
                location = touch.locationInView(StageView)
                touchArea = StageView
                StageView.clipsToBounds = false
                
                selectedSpriteIndex = 0
                selectedView = StageView.hitTest(location, withEvent: nil)
                for sprite in sprites{
                    if selectedView.isEqual(sprite.spriteImageView){
                        break
                    }
                    selectedSpriteIndex++
                }
                if selectedSpriteIndex < sprites.endIndex{
                    StageView.bringSubviewToFront(sprites[selectedSpriteIndex].spriteImageView)
                    beganLocation = sprites[selectedSpriteIndex].spriteImageView.center
                    
                    relativePoint.x = location.x - sprites[selectedSpriteIndex].spriteImageView.center.x
                    relativePoint.y = location.y - sprites[selectedSpriteIndex].spriteImageView.center.y
                }
            }
            else if SpriteSelectingAreaView.frame.contains(location){
                location = touch.locationInView(SpriteSelectingAreaView)
                touchArea = SpriteSelectingAreaView
                
            }
            else if CodingBlockSelectionAreaView.frame.contains(location){
                location = touch.locationInView(CodingBlockSelectionAreaView)
                touchArea = CodingBlockSelectionAreaView
                
            }
            else if CodingAreaView.frame.contains(location){
                location = touch.locationInView(CodingAreaView)
                touchArea = CodingAreaView
            }
            else {
                touchArea = self.view
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            var location = touch.locationInView(touchArea)
            
            if touchArea == StageView{
                if selectedSpriteIndex < sprites.endIndex{
                    var relativeLocation: CGPoint = CGPoint(x: 0, y: 0)
                    relativeLocation.x = location.x - relativePoint.x
                    relativeLocation.y = location.y - relativePoint.y
                    sprites[selectedSpriteIndex].spriteImageView.center = relativeLocation
                    sprites[selectedSpriteIndex].talkingView.center.x = sprites[selectedSpriteIndex].spriteImageView.center.x + sprites[selectedSpriteIndex].spriteImageView.image!.size.width
                    sprites[selectedSpriteIndex].talkingView.center.y = sprites[selectedSpriteIndex].spriteImageView.center.y - sprites[selectedSpriteIndex].spriteImageView.image!.size.height/1.3
                }
            }
            else if touchArea == SpriteSelectingAreaView{
                
            }
            else if touchArea == CodingBlockSelectionAreaView{
                
            }
            else if touchArea == CodingAreaView{
                
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            
            var location = touch.locationInView(touchArea)
            
            if touchArea == StageView{
                if selectedSpriteIndex < sprites.endIndex{
                    if !StageView.bounds.contains(location){
                        sprites[selectedSpriteIndex].spriteImageView.center = beganLocation
                        sprites[selectedSpriteIndex].talkingView.center.x = sprites[selectedSpriteIndex].spriteImageView.center.x + sprites[selectedSpriteIndex].spriteImageView.image!.size.width
                        sprites[selectedSpriteIndex].talkingView.center.y = sprites[selectedSpriteIndex].spriteImageView.center.y - sprites[selectedSpriteIndex].spriteImageView.image!.size.height/1.3
                    }
                    else {
                        sprites[selectedSpriteIndex].x = sprites[selectedSpriteIndex].spriteImageView.center.x
                        sprites[selectedSpriteIndex].y = sprites[selectedSpriteIndex].spriteImageView.center.y
                        
                        var content = ""
                        
                        if background != ""{
                            content += "<background name='" + background + "'>"
                        }
                        
                        content += "<sprites>"
                        
                        for sprite in sprites{
                            content += sprite.save()
                        }
                        content += "</sprites>"
                        
                        if background != ""{
                            content += "</background>"
                        }
                        
                        writeXML(content)
                    }
                }
                StageView.clipsToBounds = true
                
                //change coding area
                showSelectedSpriteBlocks()
                
            }
        }
        touchArea = self.view
    }
    
    @IBAction func hideGrid(sender: AnyObject) {
        GridImg.hidden = !GridImg.hidden
    }
    
    @IBAction func showAddSpriteView(sender: AnyObject) {
        BlurView.hidden = false
        AddSpriteView.hidden = false
    }
    
    @IBAction func hideAddSpriteView(sender: AnyObject) {
        BlurView.hidden = true
        AddSpriteView.hidden = true
        
    }
    
    @IBAction func submitAddSprite(sender: AnyObject) {
        if (selectedImage != ""){
            
            var height: String!
            var width: String!
            
            if selectedImage == "redbird"{
                height = "108"
                width = "101"
            }
            else if selectedImage == "turtle"{
                height = "88"
                width = "101"
            }
            else if selectedImage == "rabbit"{
                height = "205"
                width = "101"
            }
            else if selectedImage == "crow_standing"{
                height = "100"
                width = "101"
            }
            else if selectedImage == "pig_mum"{
                height = "162"
                width = "151"
            }
            else if selectedImage == "pig_first"{
                height = "120"
                width = "121"
            }
            else if selectedImage == "pig_second"{
                height = "125"
                width = "121"
            }
            else if selectedImage == "pig_third"{
                height = "126"
                width = "111"
            }
            else if selectedImage == "wolf"{
                height = "166"
                width = "101"
            }
            else if selectedImage == "boy"{
                height = "207"
                width = "126"
            }
            else if selectedImage == "sheep"{
                height = "59"
                width = "101"
            }
            else if selectedImage == "prince"{
                height = "274"
                width = "126"
            }
            else if selectedImage == "princess"{
                height = "226"
                width = "101"
            }
            else if selectedImage == "devil"{
                height = "130"
                width = "101"
            }
            else if selectedImage == "devil_blue"{
                height = "74"
                width = "51"
            }
            
            var content = ""
            
            if background != ""{
                content += "<background name='" + background + "'>"
            }
            
            content += "<sprites>"
            for sprite in sprites{
                content += sprite.save()
            }
            
            content += "<sprite spriteType='" + selectedImage + "' x='100' y='100' rotation='90' rotationStyle='0' height='"

            content += height
            
            content += "' width='"
            
            content += width
            
            content += "' costume='0'></sprite></sprites>"
            
            if background != ""{
                content += "</background>"
            }
            
            writeXML(content)
        }
        selectedImage = ""
        self.loadView()
        self.viewDidLoad()
        selectedSpriteIndex = sprites.count
        self.viewWillAppear(true)
        
    }
    
    @IBAction func submitDeleteSprite(sender: AnyObject) {
        var content = ""
        
        if background != ""{
            content += "<background name='" + background + "'>"
        }
        
        content += "<sprites>"
        var count = 0
        for sprite in sprites{
            if count != selectedSpriteIconIndex{
                content += sprite.save()
            }
            count++
        }
        content += "</sprites>"
        
        if background != ""{
            content += "</background>"
        }
        
        //write
        writeXML(content)
        
        self.loadView()
        self.viewDidLoad()
        self.viewWillAppear(true)
    
    }

    @IBAction func cancelDeleteSprite(sender: AnyObject) {
        selectedSpriteIconIndex = 0
        BlurView.hidden = true
        DeleteSpriteView.hidden = true
    }

    @IBAction func showAddBackgroundView(sender: AnyObject) {
        BlurView.hidden = false
        AddBackgroundView.hidden = false
    }
    
    @IBAction func hideAddBackgroundView(sender: AnyObject) {
        BlurView.hidden = true
        AddBackgroundView.hidden = true
    }
    
    @IBAction func submitAddBackground(sender: AnyObject) {
        if (selectedImage != ""){
            background = selectedImage
            var content = "<background name='" + background + "'>"
            
            content += "<sprites>"
            
            for sprite in sprites{
                content += sprite.save()
            }
            content += "</sprites></background>"
            
            writeXML(content)
            
            selectedImage = ""
            self.loadView()
            self.viewDidLoad()
            self.viewWillAppear(true)
        }
    }
    
    @IBAction func pressedFlagBtn(sender: AnyObject) {
        if !running {
            running = true
            let stopBtnImage: UIImage = UIImage(named: "button_stop")!
            FlagBtn.setImage(stopBtnImage, forState: UIControlState.Normal)
            for sprite in sprites{
                for spriteBlockArray in sprite.blocks{
                    if !spriteBlockArray.isEmpty{
                        if spriteBlockArray[0].type == "events" && spriteBlockArray[0].id == 0{
                            runSpriteArray(spriteBlockArray, sprite: sprite)
                        }
                        else{
                            continue
                        }
                    }
                }
            }
            /*
            for sprite in sprites{
                if sprite.talkingImageView.hidden == false{
                    break
                }
                else {
                    running = false
                    let flagBtnImage: UIImage = UIImage(named: "button_flag")!
                    FlagBtn.setImage(flagBtnImage, forState: UIControlState.Normal)
                }
            }
*/
        }
        else {
            running = false
            self.loadView()
            self.viewDidLoad()
            self.viewWillAppear(true)
        }
        
    }
    
    @IBAction func showMotionBlock(sender: AnyObject) {
        CodingBlockSelectionScroll.contentSize.height = 310
        for selectionBlock in selectionBlocks{
            if selectionBlock.type == "motion"{
                selectionBlock.blockView.hidden = false
            }
            else {
                selectionBlock.blockView.hidden = true
            }
        }
    }
    
    @IBAction func showEventsBlock(sender: AnyObject) {
        CodingBlockSelectionScroll.contentSize.height = 130
        for selectionBlock in selectionBlocks{
            if selectionBlock.type == "events"{
                selectionBlock.blockView.hidden = false
            }
            else {
                selectionBlock.blockView.hidden = true
            }
        }
    }
    
    @IBAction func showLooksBlock(sender: AnyObject) {
        CodingBlockSelectionScroll.contentSize.height = 230
        for selectionBlock in selectionBlocks{
            if selectionBlock.type == "looks"{
                selectionBlock.blockView.hidden = false
            }
            else {
                selectionBlock.blockView.hidden = true
            }
        }
    }
    
    @IBAction func showControlBlock(sender: AnyObject) {
        for selectionBlock in selectionBlocks{
            if selectionBlock.type == "control"{
                selectionBlock.blockView.hidden = false
            }
            else {
                selectionBlock.blockView.hidden = true
            }
        }
    }
    
    @IBAction func showSoundBlock(sender: AnyObject) {
        for selectionBlock in selectionBlocks{
            if selectionBlock.type == "sound"{
                selectionBlock.blockView.hidden = false
            }
            else {
                selectionBlock.blockView.hidden = true
            }
        }
    }

    @IBAction func showSensingBlock(sender: AnyObject) {
        for selectionBlock in selectionBlocks{
            if selectionBlock.type == "sensing"{
                selectionBlock.blockView.hidden = false
            }
            else {
                selectionBlock.blockView.hidden = true
            }
        }
    }
    
    @IBAction func showOperatorsBlock(sender: AnyObject) {
        for selectionBlock in selectionBlocks{
            if selectionBlock.type == "operators"{
                selectionBlock.blockView.hidden = false
            }
            else {
                selectionBlock.blockView.hidden = true
            }
        }
    }
    
    
    func writeXML(content: String){
        //write
        do{
            try content.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        }
        catch {
            print("xml error")
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "background"{
            background = attributeDict["name"] as String!
        }
        
        
        else if elementName == "sprite" {
            let spriteType = attributeDict["spriteType"]! as String
            let x = CGFloat(Float(attributeDict["x"]! as String)!)
            let y = CGFloat(Float(attributeDict["y"]! as String)!)
            let rotation = CGFloat(Float(attributeDict["rotation"]! as String)!)
            let rotationStyle = Int(attributeDict["rotationStyle"]! as String)
            let height = CGFloat(Float(attributeDict["height"]! as String)!)
            let width = CGFloat(Float(attributeDict["width"]! as String)!)
            let costume = Int(attributeDict["costume"]! as String)
            
            parseringSprite = Sprite(spriteType: spriteType, x: x, y: y, rotation: rotation, rotationStyle: rotationStyle!, height: height, width: width, blocks: parseringArray, costume: costume!)
        }
            
        else if elementName == "block" {
            let array = attributeDict["array"]! as String
            let shape = attributeDict["shape"]! as String
            let type = attributeDict["type"]! as String
            let id = Int(attributeDict["id"]! as String)
            let value = attributeDict["value"]! as String
            let value2 = attributeDict["value2"]! as String
            let value3 = attributeDict["value3"]! as String
            let x = CGFloat(Float(attributeDict["x"]! as String)!)
            let y = CGFloat(Float(attributeDict["y"]! as String)!)
            
            if array == "true"{
                parseringArray.append(parseringBlocks)
                parseringBlocks = []
            }
            parseringBlocks.append(Block(type: type, id: id!, shape: shape, x: x, y: y, textFieldValue: value, textFieldValue2: value2, textFieldValue3: value3))
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "sprite" {
            parseringArray.append(parseringBlocks)
            parseringBlocks = []
            parseringSprite.blocks = parseringArray
            sprites.append(parseringSprite)
            allSpriteBlocks.append(parseringArray)
            parseringArray = []
        }
    }
    
    func showSelectedSpriteBlocks(){
        var processSpriteIndex: Int = 0
        for sprite in sprites{
            for spriteBlockArray in sprite.blocks{
                for spriteBlock in spriteBlockArray{
                    if processSpriteIndex != selectedSpriteIndex{
                        spriteBlock.blockView.hidden = true
                    }
                    else {
                        spriteBlock.blockView.hidden = false
                    }
                }
            }
            processSpriteIndex++
        }
    }
    
    func deleteSprite(sender: UILongPressGestureRecognizer){
        
        if(sender.state == UIGestureRecognizerState.Began){
            for sprite in sprites{
                if sprite.spriteIconImageView.frame.contains(sender.locationInView(SpriteSelectingScroll)){
                    break
                }
                selectedSpriteIconIndex++
            }
            DeleteSpriteView.hidden = false
            BlurView.hidden = false
        }
        
            
    }
    
    func moveBlock(sender: UIPanGestureRecognizer){
        let location: CGPoint = sender.locationInView(ScratchView)
        if sender.state == UIGestureRecognizerState.Began{
            selectedView = ScratchView.hitTest(location, withEvent: nil)
            selectedBlockArea = selectedView.superview
            
            if selectedBlockArea == CodingBlockSelectionScroll{
                CodingBlockSelectionScroll.clipsToBounds = false
                for selectionBlock in selectionBlocks{
                    if selectedView.isEqual(selectionBlock.blockView){
                        if selectedView.isKindOfClass(BlockShape){
                            print("yes")
                        }
                        else {
                            print(selectedView)
                        }
                        break
                    }
                    selectedBlockIndex++
                }
                
                if selectedBlockIndex < selectionBlocks.endIndex{
                    CodingBlockSelectionScroll.bringSubviewToFront(selectionBlocks[selectedBlockIndex].blockView)
                    beganLocation = selectionBlocks[selectedBlockIndex].blockView.center
                    
                    relativePoint.x = sender.locationInView(selectedView.superview).x - selectionBlocks[selectedBlockIndex].blockView.center.x
                    relativePoint.y = sender.locationInView(selectedView.superview).y - selectionBlocks[selectedBlockIndex].blockView.center.y
                }
                
            }
            else if selectedBlockArea == CodingAreaScroll{
                CodingAreaScroll.clipsToBounds = false
                selectedBlockArrayIndex = 0
                
                for spriteBlockArray in sprites[selectedSpriteIndex].blocks{
                    for spriteBlock in spriteBlockArray{
                        if selectedView.isEqual(spriteBlock.blockView){
                            break
                        }
                        selectedBlockIndex++
                    }
                    
                    if selectedBlockIndex < spriteBlockArray.endIndex{
                        break
                    }
                    selectedBlockIndex = 0
                    selectedBlockArrayIndex++
                }
                
                if selectedBlockArrayIndex < sprites[selectedSpriteIndex].blocks.endIndex{
                    for index in selectedBlockIndex ... sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex].endIndex - 1{
                        CodingAreaScroll.bringSubviewToFront(sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex][index].blockView)
                    }
                    beganLocation = sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex][selectedBlockIndex].blockView.center
                    
                    relativePoint.x = sender.locationInView(selectedView.superview).x - sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex][selectedBlockIndex].blockView.center.x
                    relativePoint.y = sender.locationInView(selectedView.superview).y - sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex][selectedBlockIndex].blockView.center.y
                }
            }
        }
        else if sender.state == UIGestureRecognizerState.Changed{
            if selectedBlockArea == CodingBlockSelectionScroll{
                if selectedBlockIndex < selectionBlocks.endIndex{
                    var relativeLocation: CGPoint = CGPoint(x: 0, y: 0)
                    relativeLocation.x = sender.locationInView(selectedView.superview).x - relativePoint.x
                    relativeLocation.y = sender.locationInView(selectedView.superview).y - relativePoint.y
                    selectionBlocks[selectedBlockIndex].blockView.center = relativeLocation
                    
                    
                    if selectedSpriteIndex < sprites.endIndex{
                        nearByArrayIndex = 0
                        for spriteBlockArray in sprites[selectedSpriteIndex].blocks{
                            for spriteBlock in spriteBlockArray{
                                if abs(spriteBlock.blockView.center.x - selectedView.superview!.convertPoint(selectedView.center, toView: CodingAreaScroll).x) <= 40{
                                    
                                    if (spriteBlock.blockView.center.y - selectedView.superview!.convertPoint(selectedView.center, toView: CodingAreaScroll).y <= 70) && (spriteBlock.blockView.center.y - selectedView.superview!.convertPoint(selectedView.center, toView: CodingAreaScroll).y >= 0){
                                        positionOfNearBy = "above"
                                        break
                                    }
                                    else if (selectedView.superview!.convertPoint(selectedView.center, toView: CodingAreaScroll).y - spriteBlock.blockView.center.y <= 70) && (selectedView.superview!.convertPoint(selectedView.center, toView: CodingAreaScroll).y - spriteBlock.blockView.center.y >= 0){
                                        positionOfNearBy = "below"
                                        break
                                    }
                                }
                                nearByBlockIndex++
                            }
                            
                            if nearByBlockIndex < spriteBlockArray.endIndex{
                                break
                            }
                            
                            nearByBlockIndex = 0
                            nearByArrayIndex++
                        }
                    }
                }
                if selectedSpriteIndex < sprites.endIndex{
                    if nearByArrayIndex < sprites[selectedSpriteIndex].blocks.endIndex{
                        //show available
                    }
                }
                
            }
            else if selectedBlockArea == CodingAreaScroll{
                if selectedBlockArrayIndex < sprites[selectedSpriteIndex].blocks.endIndex{
                    for index in selectedBlockIndex ... sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex].endIndex - 1{
                        
                        var relativeHeight: CGFloat = 0
                        
                        if !(index == selectedBlockIndex){
                            for innerIndex in selectedBlockIndex ... index - 1{
                                relativeHeight += sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex][innerIndex].blockView.frame.size.height
                            }
                        }
                        var relativeLocation: CGPoint = CGPoint(x: 0, y: 0)
                        relativeLocation.x = sender.locationInView(selectedView.superview).x - relativePoint.x
                        relativeLocation.y = sender.locationInView(selectedView.superview).y - relativePoint.y + relativeHeight
                        sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex][index].blockView.center = relativeLocation
                    }
                    
                    nearByArrayIndex = 0
                    for spriteBlockArray in sprites[selectedSpriteIndex].blocks{
                        for spriteBlock in spriteBlockArray{
                            if nearByArrayIndex == selectedBlockArrayIndex{
                                if nearByBlockIndex >= selectedBlockIndex{
                                    nearByBlockIndex++
                                    continue
                                }
                            }
                            
                            if abs(spriteBlock.blockView.center.x - selectedView.center.x) <= 40{
                                
                                if (spriteBlock.blockView.center.y - selectedView.center.y <= 70) && (spriteBlock.blockView.center.y - selectedView.center.y >= 0){
                                    positionOfNearBy = "above"
                                    break
                                }
                                else if (selectedView.center.y - spriteBlock.blockView.center.y <= 70) && (selectedView.center.y - spriteBlock.blockView.center.y >= 0){
                                    positionOfNearBy = "below"
                                    break
                                }
                            }
                            nearByBlockIndex++
                        }
                        
                        if nearByBlockIndex < spriteBlockArray.endIndex{
                            break
                        }
                        
                        nearByBlockIndex = 0
                        nearByArrayIndex++
                    }
                    
                    if nearByArrayIndex < sprites[selectedSpriteIndex].blocks.endIndex{
                        //show available
                        print(positionOfNearBy)
                    }
                }
            }
        }
        else if sender.state == UIGestureRecognizerState.Ended{
            if selectedBlockArea == CodingBlockSelectionScroll{
                if CodingAreaView.frame.contains(location){
                    if selectedSpriteIndex < sprites.endIndex{
                        //create
                        if nearByArrayIndex < sprites[selectedSpriteIndex].blocks.endIndex{
                            //existing array
                            
                            var panBlock = UIPanGestureRecognizer(target: self, action: "moveBlock:")
                            
                            var newBlock: Block!
                            
                            var existBlock = sprites[selectedSpriteIndex].blocks[nearByArrayIndex][nearByBlockIndex]
                            
                            if positionOfNearBy == "above"{
                                newBlock = Block(type: selectionBlocks[selectedBlockIndex].type, id: selectionBlocks[selectedBlockIndex].id, shape: selectionBlocks[selectedBlockIndex].shape, x: existBlock.blockView.center.x - selectionBlocks[selectedBlockIndex].blockView.frame.size.width/2, y: existBlock.blockView.center.y - (selectionBlocks[selectedBlockIndex].blockView.frame.size.height*3/2), textFieldValue: selectionBlocks[selectedBlockIndex].textFieldValue, textFieldValue2: selectionBlocks[selectedBlockIndex].textFieldValue2, textFieldValue3: selectionBlocks[selectedBlockIndex].textFieldValue3)
                            }
                            else {
                                newBlock = Block(type: selectionBlocks[selectedBlockIndex].type, id: selectionBlocks[selectedBlockIndex].id, shape: selectionBlocks[selectedBlockIndex].shape, x: existBlock.blockView.center.x - selectionBlocks[selectedBlockIndex].blockView.frame.size.width/2, y: existBlock.blockView.center.y +  selectionBlocks[selectedBlockIndex].blockView.frame.size.height/2, textFieldValue: selectionBlocks[selectedBlockIndex].textFieldValue, textFieldValue2: selectionBlocks[selectedBlockIndex].textFieldValue2, textFieldValue3: selectionBlocks[selectedBlockIndex].textFieldValue3)
                            }
                            newBlock.blockView.addGestureRecognizer(panBlock)
                            
                            if positionOfNearBy == "above"{
                                sprites[selectedSpriteIndex].blocks[nearByArrayIndex].insert(newBlock, atIndex: nearByBlockIndex)
                            }
                            else {
                                if nearByBlockIndex + 1 < sprites[selectedSpriteIndex].blocks[nearByArrayIndex].endIndex{
                                    sprites[selectedSpriteIndex].blocks[nearByArrayIndex].insert(newBlock, atIndex: nearByBlockIndex + 1)
                                    //following block
                                    for index in nearByBlockIndex + 2 ... sprites[selectedSpriteIndex].blocks[nearByArrayIndex].endIndex - 1{
                                        sprites[selectedSpriteIndex].blocks[nearByArrayIndex][index].y += selectionBlocks[selectedBlockIndex].blockView.frame.size.height
                                        
                                    }
                                }
                                else {
                                    sprites[selectedSpriteIndex].blocks[nearByArrayIndex].append(newBlock)
                                }
                            }
                        }
                        else {
                            //new array
                            var relativeLocation: CGPoint = CGPoint(x: 0, y: 0)
                            relativeLocation.x = sender.locationInView(CodingAreaScroll).x - relativePoint.x - selectionBlocks[selectedBlockIndex].blockView.frame.size.width/2
                            relativeLocation.y = sender.locationInView(CodingAreaScroll).y - relativePoint.y - selectionBlocks[selectedBlockIndex].blockView.frame.size.height/2
                            
                            var panBlock = UIPanGestureRecognizer(target: self, action: "moveBlock:")
                            var newBlock = Block(type: selectionBlocks[selectedBlockIndex].type, id: selectionBlocks[selectedBlockIndex].id, shape: selectionBlocks[selectedBlockIndex].shape, x: relativeLocation.x, y: relativeLocation.y, textFieldValue: selectionBlocks[selectedBlockIndex].textFieldValue, textFieldValue2: selectionBlocks[selectedBlockIndex].textFieldValue2, textFieldValue3: selectionBlocks[selectedBlockIndex].textFieldValue3)
                            
                            newBlock.blockView.addGestureRecognizer(panBlock)
                            var nearbyBlockArray: Array<Block> = []
                            nearbyBlockArray.append(newBlock)
                            sprites[selectedSpriteIndex].blocks.append(nearbyBlockArray)
                            //allSpriteBlocks[selectedSpriteIndex].append(nearbyBlockArray)
                            
                        }
                        
                        //save
                        var content = ""
                        
                        if background != ""{
                            content += "<background name='" + background + "'>"
                        }
                        
                        content += "<sprites>"
                        
                        for sprite in sprites{
                            content += sprite.save()
                        }
                        content += "</sprites>"
                        
                        if background != ""{
                            content += "</background>"
                        }
                        
                        //write
                        writeXML(content)
                        
                        self.loadView()
                        self.viewDidLoad()
                        self.viewWillAppear(true)
                    }
                    selectionBlocks[selectedBlockIndex].blockView.center = beganLocation
                }
                else {
                    selectionBlocks[selectedBlockIndex].blockView.center = beganLocation
                }
            }
            else if selectedBlockArea == CodingAreaScroll{
                if !CodingAreaView.frame.contains(location){
                    //remove from selectedBlockIndex to endIndex but not include endIndex
                    sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex].removeRange(selectedBlockIndex..<sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex].endIndex)
                    
                }
                else {
                    //save location
                    for index in selectedBlockIndex ... sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex].endIndex - 1{
                        sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex][index].x = sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex][index].blockView.frame.origin.x
                        sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex][index].y = sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex][index].blockView.frame.origin.y
                    }
                    
                    //new array and remove
                    var newBlockArray: Array<Block> = []
                    for index in selectedBlockIndex ... sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex].endIndex - 1{
                        
                        newBlockArray.append(sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex][index])
                        
                    }
                    sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex].removeRange(selectedBlockIndex..<sprites[selectedSpriteIndex].blocks[selectedBlockArrayIndex].endIndex)
                    
                    
                    //insert
                    if nearByArrayIndex < sprites[selectedSpriteIndex].blocks.endIndex{
                        if positionOfNearBy == "above"{
                            for newBlock in newBlockArray{
                                var existBlock = sprites[selectedSpriteIndex].blocks[nearByArrayIndex][nearByBlockIndex]
                                newBlock.x = existBlock.blockView.frame.origin.x
                                newBlock.y = existBlock.blockView.frame.origin.y - existBlock.blockView.frame.size.height
                                for index in 0 ..< nearByBlockIndex{
                                    sprites[selectedSpriteIndex].blocks[nearByArrayIndex][index].y -= newBlock.blockView.frame.size.height
                                }
                                
                                sprites[selectedSpriteIndex].blocks[nearByArrayIndex].insert(newBlock, atIndex: nearByBlockIndex)
                                
                                nearByBlockIndex++
                            }
                            
                        }
                        else {
                            if nearByBlockIndex + 1 < sprites[selectedSpriteIndex].blocks[nearByArrayIndex].endIndex{
                                
                                
                                //var numOfNewBlock: Int = 1
                                for newBlock in newBlockArray{
                                    var existBlock = sprites[selectedSpriteIndex].blocks[nearByArrayIndex][nearByBlockIndex]
                                    newBlock.x = existBlock.x
                                    newBlock.y = existBlock.y + existBlock.blockView.frame.size.height
                                    for index in nearByBlockIndex + 1 ..< sprites[selectedSpriteIndex].blocks[nearByArrayIndex].endIndex{
                                        sprites[selectedSpriteIndex].blocks[nearByArrayIndex][index].y += newBlock.blockView.frame.size.height
                                    }
                                    sprites[selectedSpriteIndex].blocks[nearByArrayIndex].insert(newBlock, atIndex: nearByBlockIndex + 1) // because of 1
                                    nearByBlockIndex++
                                }
                            }
                                //at the end
                            else {
                                var existBlock = sprites[selectedSpriteIndex].blocks[nearByArrayIndex][nearByBlockIndex]
                                var relativeHeight: CGFloat = existBlock.y + existBlock.blockView.frame.size.height
                                for newBlock in newBlockArray{
                                    newBlock.x = existBlock.x
                                    newBlock.y = relativeHeight
                                    relativeHeight += newBlock.blockView.frame.size.height
                                }
                                
                                
                                sprites[selectedSpriteIndex].blocks[nearByArrayIndex] += newBlockArray
                            }
                        }
                    }
                        //new
                    else{
                        sprites[selectedSpriteIndex].blocks.append(newBlockArray)
                    }
                }
                
                //save in xml
                var content = ""
                
                if background != ""{
                    content += "<background name='" + background + "'>"
                }
                
                content += "<sprites>"
                
                for sprite in sprites{
                    content += sprite.save()
                }
                content += "</sprites>"
                
                if background != ""{
                    content += "</background>"
                }
                
                //write
                writeXML(content)
                
                self.loadView()
                self.viewDidLoad()
                self.viewWillAppear(true)
            }
            selectedBlockArrayIndex = 0
            selectedBlockIndex = 0
            CodingBlockSelectionScroll.clipsToBounds = true
            CodingAreaScroll.clipsToBounds = true
            nearByArrayIndex = 0
            nearByBlockIndex = 0
        }
    }
    
    func selectSprite (sender: UIButton!) {
        let pressedBtn: UIButton = sender
        var spriteNameIndex: Int = 0
        for sprite in spriteLibraryArray{
            if pressedBtn.currentBackgroundImage == sprite{
                break
            }
            spriteNameIndex++
        }
        selectedImage = spriteNameArray[spriteNameIndex]
    }
    
    func selectBackground (sender: UIButton!) {
        let pressedBtn: UIButton = sender
        var backgroundNameIndex: Int = 0
        for background in backgroundLibraryArray{
            if pressedBtn.currentBackgroundImage == background{
                break
            }
            backgroundNameIndex++
        }
        selectedImage = backgroundNameArray[backgroundNameIndex]
    }
    
    func runSpriteArray(spriteBlockArray: Array<Block>, sprite: Sprite){
        let oneDArrayQueue = dispatch_queue_create("spriteBlockQueue", nil)
        dispatch_async(oneDArrayQueue) {
            for spriteBlock in spriteBlockArray{
                spriteBlock.runBlock(sprite)
            }
        }
    }

}

