//
//  ViewController.swift
//  Reversi
//
//  Created by Владислав Эдуардович Дембский on 12.02.16.
//  Copyright © 2016 Vladislav Dembskiy. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    private var scene: GameLogicUI!
    private var gameLogic: GameLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = self.view as! SKView
        let size = CGSize(width: 640, height: 760)
        scene = GameLogicUI(size: size)
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFit
        skView.presentScene(scene)
        gameLogic = GameLogic(scene: scene)
        gameLogic.setInitialBoard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(scene)
            if let node: SKSpriteNode = scene.nodeAtPoint(location) as? SKSpriteNode {
                if let num = Int(node.name!) {
                    let row = num / 10
                    let column = num % 10
                    gameLogic.cellPressed(row,column)
                }
            } else {gameLogic.cellPressed(-1,-1)}
        }
    }

}

