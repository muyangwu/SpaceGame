//
//  GameScene.swift
//  SpaceGame
//
//  Created by muyang on 3/8/17.
//  Copyright © 2017 amw. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  var starfield:SKEmitterNode!
  var player:SKSpriteNode!
  var scoreLabel:SKLabelNode!
  var score:Int = 0{
    didSet{
      scoreLabel.text = "Score: \(score)"
    }
  }
  
  var gameTimer:Timer!
  
  var possibleAliens = ["alien", "alien2", "alien3"]
    override func didMove(to view: SKView) {
      
      starfield = SKEmitterNode(fileNamed: "Starfield")
      starfield.position = CGPoint(x: self.frame.size.width - 350, y: self.frame.size.height)
      starfield.advanceSimulationTime(10)
      self.addChild(starfield)
      
      starfield.zPosition = -1
      
      player = SKSpriteNode(imageNamed: "shuttle")
      
      player.position = CGPoint(x: self.frame.size.width / 2, y: player.size.height / 2 + 20)
      self.addChild(player)
      
      self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
      self.physicsWorld.contactDelegate = self
      
      
      scoreLabel = SKLabelNode(text: "Score: 0")
      scoreLabel.position  = CGPoint(x: 100, y: self.frame.size.height - 40)
      scoreLabel.fontName = "AmericanTypewriter"
      scoreLabel.fontSize = 36
      scoreLabel.fontColor = UIColor.white
      score = 0
      
      self.addChild(scoreLabel)
      
      gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
      
      
    }
  
  func addAlien(){
    possibleAliens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleAliens) as! [String]
    
    let alien = SKSpriteNode(imageNamed: possibleAliens[0])
    let randomAlienPosition = GKRandomDistribution(lowestValue: 0, highestValue: 414)
    let position  = CGFloat(randomAlienPosition.nextInt())
    
    alien.position = CGPoint(x: position, y: self.frame.size.height + alien.size.height)
    
    alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
    alien.physicsBody?.isDynamic = true
    
    
  }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
