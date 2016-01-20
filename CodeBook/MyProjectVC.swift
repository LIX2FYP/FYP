//
//  MyProjectVC.swift
//  CodeBook
//
//  Created by Joey Cheng on 12/1/2016.
//  Copyright © 2016 FYP. All rights reserved.
//

import Foundation
import UIKit

class MyProjectVC: UIViewController {
    
    //View
    @IBOutlet weak var ProjectView: UIView!
    
    //Scroll
    @IBOutlet weak var ProjectScroll: UIScrollView!
    
    //button
    @IBOutlet weak var PerviousBtn: UIButton!
    @IBOutlet weak var AddProjectBtn: UIButton!
    
    //label
    @IBOutlet weak var MyProjectLabel: UILabel!
    
    //image View
    @IBOutlet weak var BirdImg: UIImageView!
    
    
    //var
    var projectName = ""
    var projectNumber = 1
    var projects: Array<String> = []
    let type = ".xml"
    
    let docsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
    var filePath = ""
    let manager = NSFileManager.defaultManager()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //init height
        ProjectScroll.contentSize.height = 668
        
        do {
            let directoryContents = try NSFileManager.defaultManager().contentsOfDirectoryAtURL(NSURL(fileURLWithPath: docsPath as String), includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions())
            let xmlFiles = directoryContents.filter(){ $0.pathExtension == "xml" }.map{ $0.lastPathComponent}
            
            for xmlFile in xmlFiles {
                let index = (xmlFile! as String).endIndex.advancedBy(-4)
                let content = (xmlFile! as String).substringToIndex(index)
                projects.append(content)
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        if projects.count >= 6 {
            for index in 1...(projects.count/3 - 1){
                ProjectScroll.contentSize.height += 300
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var x: CGFloat  = 400
        var y: CGFloat = 86
        
        for project in projects{
            let projectImage: UIImage = UIImage(named: "button_existing_project")!
            let projectBtn = UIButton(type: UIButtonType.System) as UIButton
            projectBtn.setBackgroundImage(projectImage, forState: UIControlState.Normal)
            projectBtn.frame = CGRectMake(x, y, 243, 181)
            projectBtn.setTitle(project, forState: UIControlState.Normal)
            projectBtn.addTarget(self, action: "existingProject:", forControlEvents: UIControlEvents.TouchUpInside)
            ProjectScroll.addSubview(projectBtn)
            
            if (x == 94) || (x == 400){
                x += 306
            }
            else if x == 706 {
                x = 94
                y += 267
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func addProject(sender: AnyObject) {
        while true{
            projectName = "Project" + String(projectNumber)
            if projects.contains(projectName){
                projectNumber++
            }
            else {
                break
            }
        }
        print(docsPath)
        filePath = docsPath.stringByAppendingPathComponent(projectName+type)
        
        let content = "<sprites><sprite spriteType='redbird' x='250' y='100' rotation='90' rotationStyle='2' height='108' width='101'></sprite></sprites>"
        do{
            try content.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        }
        catch {
            print("xml error")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "AddProjectSegue"){
            var svc = segue.destinationViewController as! ScratchVC
            svc.projectName = projectName
        }
        
        if (segue.identifier == "ExistProjectSegue"){
            var svc = segue.destinationViewController as! ScratchVC
            svc.projectName = projectName
        }
    }
    
    func existingProject (sender: UIButton!) {
        let pressedBtn: UIButton = sender
        projectName = pressedBtn.currentTitle! as String
        
        performSegueWithIdentifier("ExistProjectSegue", sender: nil)
    }
    
}