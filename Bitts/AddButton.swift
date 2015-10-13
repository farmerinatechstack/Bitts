//
//  AddButton.swift
//  Bitts
//
//  Created by Hassan Karaouni on 10/4/15.
//  Copyright © 2015 HKII Productions. All rights reserved.
//

import SpriteKit

class AddButton {
    let scene: SKScene
    
    var buttonBG: SKShapeNode
    var horizontalBar: SKShapeNode
    var verticalBar: SKShapeNode
    
    var fr = CGFloat(0.0)
    var fg = CGFloat(0.0)
    var fb = CGFloat(0.0)
    var fa = CGFloat(0.0)
    var tr = CGFloat(0.0)
    var tg = CGFloat(0.0)
    var tb = CGFloat(0.0)
    var ta = CGFloat(0.0)

    init(radius: CGFloat, scene: SKScene) {
        self.scene = scene
        
        buttonBG = SKShapeNode(circleOfRadius: radius)
        buttonBG.fillColor = BittConstants.BITT_COLOR
        buttonBG.strokeColor = BittConstants.BITT_COLOR
        let buttonBody = SKPhysicsBody(circleOfRadius: radius)
        buttonBody.friction = 0
        buttonBody.dynamic = false
        buttonBG.physicsBody = buttonBody

        let hashLength = radius * 1.25
        let horizontalRect = CGRect(x: 0, y: 0, width: hashLength, height: 1)
        let horizontalPath = CGPathCreateWithRect(horizontalRect, nil)
        horizontalBar = SKShapeNode(path: horizontalPath, centered: true)
        horizontalBar.fillColor = SKColor.whiteColor()
        horizontalBar.strokeColor = SKColor.whiteColor()

        let verticalRect = CGRect(x: 0, y: 0, width: 1, height: hashLength)
        let verticalPath = CGPathCreateWithRect(verticalRect, nil)
        verticalBar = SKShapeNode(path: verticalPath, centered: true)
        verticalBar.fillColor = SKColor.whiteColor()
        verticalBar.strokeColor = SKColor.whiteColor()
    }

    func getButtonBG() -> SKShapeNode {
        return buttonBG
    }

    func drawButton(xPosition: CGFloat, _ yPosition: CGFloat) {
        buttonBG.position = CGPoint(x: xPosition, y: yPosition)
        horizontalBar.position = CGPointMake(xPosition, yPosition)
        verticalBar.position = CGPointMake(xPosition, yPosition)

        scene.addChild(buttonBG)
        scene.addChild(horizontalBar)
        scene.addChild(verticalBar)
    }

    func toggleToAddBitScreen() {
        /*
        let rotate = SKAction.rotateToAngle(CGFloat(0.785398), duration: NSTimeInterval(0.5))
        horizontalBar.runAction(rotate)
        verticalBar.runAction(rotate)
        
        BittConstants.BITT_COLOR.getRed(&fr, green: &fg, blue: &fb, alpha: &fa)
        BittConstants.CANCEL_COLOR.getRed(&tr, green: &tg, blue: &tb, alpha: &ta)
        
        let duration = NSTimeInterval(0.5)
        let changeColor = SKAction.customActionWithDuration(duration,
            actionBlock: { (node: SKNode!, elapsedTime: CGFloat) -> Void in
                let fraction = CGFloat(elapsedTime / CGFloat(duration))
                let transColor = UIColor(red: self.lerp(self.fr, b: self.tr, fraction: fraction),
                    green: self.lerp(self.fg, b: self.tg, fraction: fraction),
                    blue: self.lerp(self.fb, b: self.tb, fraction: fraction),
                    alpha: self.lerp(self.fa, b: self.ta, fraction: fraction))
                
                (node as! SKShapeNode).fillColor = transColor
                (node as! SKShapeNode).strokeColor = transColor
        })
        buttonBG.runAction(changeColor)
        */
    }
    
    func toggleToHomeScreen() {
        /*
        let rotate = SKAction.rotateToAngle(CGFloat(0), duration: NSTimeInterval(0.5))
        horizontalBar.runAction(rotate)
        verticalBar.runAction(rotate)
        
        BittConstants.CANCEL_COLOR.getRed(&fr, green: &fg, blue: &fb, alpha: &fa)
        BittConstants.BITT_COLOR.getRed(&tr, green: &tg, blue: &tb, alpha: &ta)
        
        let duration = NSTimeInterval(0.5)
        let changeColor = SKAction.customActionWithDuration(duration,
            actionBlock: { (node: SKNode!, elapsedTime: CGFloat) -> Void in
                let fraction = CGFloat(elapsedTime / CGFloat(duration))
                let transColor = UIColor(red: self.lerp(self.fr, b: self.tr, fraction: fraction),
                    green: self.lerp(self.fg, b: self.tg, fraction: fraction),
                    blue: self.lerp(self.fb, b: self.tb, fraction: fraction),
                    alpha: self.lerp(self.fa, b: self.ta, fraction: fraction))
                
                (node as! SKShapeNode).fillColor = transColor
                (node as! SKShapeNode).strokeColor = transColor
        })
        buttonBG.runAction(changeColor)
        */
    }
    
    func lerp(a : CGFloat, b : CGFloat, fraction : CGFloat) -> CGFloat {
        return (b-a) * fraction + a
    }
}