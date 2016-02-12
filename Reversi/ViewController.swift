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

    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = self.view as! SKView
        let size = CGSize(width: 640, height: 760)
        let scene = GameLogicUI(size: size)
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFit
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

