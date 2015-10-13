//
//  DayBittsScene.swift
//  Bitts
//
//  Created by Hassan Karaouni on 9/27/15.
//  Copyright (c) 2015 HKII Productions. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let TopBorder:       UInt32 = 0
    static let RightBorder:     UInt32 = 0b1
    static let BottomBorder:    UInt32 = 0b10
    static let LeftBorder:      UInt32 = 0b100
    static let Bitt:            UInt32 = 0b1000
    static let DayBitt:         UInt32 = 0b10000
}

protocol DayBittsSceneDelegate {
    func transitionToAddBitt(scene: DayBittsScene)
    func transitionToViewBitt(scene: DayBittsScene, bitt: SKShapeNode)
}

class DayBittsScene: SKScene {
    var sceneDelegate: DayBittsSceneDelegate?
    
    var dayLabel:       SKLabelNode!
    var dayBitt:        SKShapeNode!

    var bitts:          [SKShapeNode] = []
    var connections:    [SKShapeNode] = []

    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        setupScene()
        dayBitt = makeDayBitt() as SKShapeNode

        self.addChild(dayBitt)
    }

    override func update(currentTime: NSTimeInterval) {
        for c in connections {
            c.removeFromParent()
        }
        connections = []

        for b in bitts {
            updateVelocity(b)
            drawConnection(b)
        }
    }

    private func drawConnection(bitt: SKShapeNode) {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, bitt.position.x, bitt.position.y)
        CGPathAddLineToPoint(path, nil, getDayBittX(bitt), getDayBittY(bitt))

        let connection = SKShapeNode()
        connection.path = path
        connection.strokeColor = BittConstants.BITT_COLOR
        connection.lineWidth = 2

        connections.append(connection)
        self.addChild(connection)
    }
    
    private func getDayBittX(bitt: SKShapeNode) -> CGFloat {
        let xDist = bitt.position.x - dayBitt.position.x
        let yDist = bitt.position.y - dayBitt.position.y
        let absoluteDist = sqrt(pow(Double(xDist),Double(2)) + pow(Double(yDist),Double(2)))

        let xOffset = xDist / CGFloat(absoluteDist) * frame.width/6

        return dayBitt.position.x + xOffset
    }
    
    private func getDayBittY(bitt: SKShapeNode) -> CGFloat {
        let xDist = bitt.position.x - dayBitt.position.x
        let yDist = bitt.position.y - dayBitt.position.y
        let absoluteDist = sqrt(
            pow(Double(xDist),Double(2)) + pow(Double(yDist),Double(2)))

        let yOffset = yDist / CGFloat(absoluteDist) * frame.width/6

        return dayBitt.position.y + yOffset
    }

    /*
     * Updates the velocity for a bitt on the screen if necessary.
     */
    private func updateVelocity(bitt: SKShapeNode) {
        if fabs(bitt.physicsBody!.velocity.dx) < 5 {
            let directionalValue = (bitt.position.x > frame.width/2) ? -1.0 : 1.0
            let xImpulse = CGFloat(15 * directionalValue)
            bitt.physicsBody?.applyImpulse(CGVectorMake(xImpulse, 0))
        }

        if fabs(bitt.physicsBody!.velocity.dy) < 5 {
            let directionalValue = (bitt.position.y > frame.height/2) ? -1 : 1
            let yImpulse = CGFloat(15 * directionalValue)
            bitt.physicsBody?.applyImpulse(CGVectorMake(0, yImpulse))
        }
    }

    /*
     * Makes and returns a bitt.
     */
    func makeBitt() -> SKShapeNode {
        let bittRadius = frame.width / 20
        let bittBorder = SKPhysicsBody(circleOfRadius: bittRadius)
        bittBorder.friction = 0
        bittBorder.restitution = 1
        bittBorder.linearDamping = 0
        bittBorder.angularDamping = 0

        let bitt = SKShapeNode(circleOfRadius: bittRadius)
        bitt.name = BittConstants.BITT_NAME
        bitt.physicsBody = bittBorder
        bitt.fillColor = BittConstants.BITT_COLOR
        bitt.strokeColor = BittConstants.BITT_COLOR
        bitt.position = CGPoint(x: 200, y: 200)
        
        bitt.physicsBody!.velocity = CGVectorMake(200.0, 200.0)
        bitts.append(bitt)
        self.addChild(bitt)

        updateDayBittColor()

        return bitt
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            // Detect touch in the scene.
            let location = touch.locationInNode(self)
            let nodeAtLocation = self.nodeAtPoint(location)
            
            // Check if add bitt button has been touched.
            if (nodeAtLocation.name == BittConstants.DAY_BITT_NAME) {
                transitionToAddBitt()
            } else if (nodeAtLocation.name == BittConstants.BITT_NAME) {
                let bitt = nodeAtLocation as! SKShapeNode
                transitionToViewBitt(bitt)
            }
        }
    }
    
    func transitionToAddBitt() {        
        if let delegate = self.sceneDelegate {
            delegate.transitionToAddBitt(self)
        }
    }
    
    func transitionToViewBitt(node: SKShapeNode) {
        if let delegate = self.sceneDelegate {
            delegate.transitionToViewBitt(self, bitt: node)
        }
    }

    private func updateDayBittColor() {
        let bittFraction = Double(self.bitts.count) / 10.0
        self.dayBitt.fillColor = SKColor(red: 85.0/255, green: 218.0/255, blue: 225.0/255, alpha: CGFloat(bittFraction))
    }
    
    // CONFIGURES THE SETUP FOR THE SCENE \\
    
    private func setupScene() {
        self.backgroundColor = SKColor(red: 74.0/255, green: 74.0/255, blue: 74.0/255, alpha: 1)
        physicsWorld.gravity = CGVector.zero

        dayLabel = SKLabelNode(text: "10/9")
        dayLabel.fontSize = 54;
        dayLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-dayLabel.frame.height/2)

        self.addChild(dayLabel)
        
        setupBorders()
    }
    
    /*
    * Makes and returns the central day bitt.
    */
    private func makeDayBitt() -> SKShapeNode {
        let bittRadius = frame.width / 6
        
        let dayBitt = SKShapeNode(circleOfRadius: bittRadius)
        dayBitt.name = BittConstants.DAY_BITT_NAME
        
        // Set the colors of the day Bitt.
        dayBitt.physicsBody = SKPhysicsBody(circleOfRadius: bittRadius)
        dayBitt.physicsBody?.dynamic = false
        dayBitt.fillColor = SKColor.clearColor()
        dayBitt.lineWidth = CGFloat(5)
        dayBitt.strokeColor = BittConstants.BITT_COLOR
        
        // Position the day Bitt.
        dayBitt.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        return dayBitt
    }

    /*
     * Build the walls of the scene in order: top, right, bottom, left
     */
    private func setupBorders() {
        setupBorder(frame.origin.x, y: frame.height, width: frame.width, height: 1)
        setupBorder(frame.width, y: frame.origin.y, width: 1, height: frame.height)
        setupBorder(frame.origin.x, y: frame.origin.y, width: frame.width, height: 1)
        setupBorder(frame.origin.x, y: frame.origin.y, width: 1, height: frame.height)
    }

    /*
     * Builds an individual wall of the scene.
     */
    private func setupBorder(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let borderBody = SKPhysicsBody(
            edgeLoopFromRect: CGRectMake(x, y, width, height))
        borderBody.friction = 0
        let wall = SKNode()
        wall.physicsBody = borderBody
        addChild(wall)
    }
}