//
//  DayBittsVC.swift
//  Bitts
//
//  Created by Hassan Karaouni on 9/27/15.
//  Copyright (c) 2015 HKII Productions. All rights reserved.
//

import QuartzCore
import SpriteKit
import UIKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! DayBittsScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class DayBittsVC: UIViewController, DayBittsSceneDelegate, AddBittDelegate {
    var bittScene: DayBittsScene!
    let transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = DayBittsScene.unarchiveFromFile("DayBittsSKS") as? DayBittsScene {
            bittScene = scene
            
            // Configure the view.
            let skView = self.view as! SKView

            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true

            /* Set the scale mode to scale to fit the window */
            bittScene.scaleMode = .AspectFill
            skView.presentScene(bittScene)

            /* Set a delegate link between view and scene */
            bittScene.sceneDelegate = self
        }
    }
    
    func addBitt(title: String, text: String) {
        bittScene.makeBitt()
    }
    
    func transitionToAddBitt(scene: DayBittsScene) {
        performSegueWithIdentifier("toAddBittVC", sender: scene)
    }
    
    func transitionToViewBitt(scene: DayBittsScene, bitt: SKShapeNode) {
        performSegueWithIdentifier("toViewBittVC", sender: bitt)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let toViewController = segue.destinationViewController as UIViewController
        
        self.definesPresentationContext = true
        toViewController.transitioningDelegate = self.transitionManager
        toViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        
        
        if segue.identifier == "toAddBittVC" {
            let destinationVC = segue.destinationViewController as! AddBittVC
            destinationVC.addDelegate = self
        } else if segue.identifier == "toViewBittVC" {
            let bitt = sender as! SKShapeNode
            
            let destinationVC = segue.destinationViewController as! ViewBittVC
            destinationVC.bittTitleStr = "Bitt Title"
            destinationVC.bittTextStr = "Bitt Position: \(bitt.position.x), \(bitt.position.y)"
        }
    }
    
    @IBAction func unwindToViewController(sender: UIStoryboardSegue) {}

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
