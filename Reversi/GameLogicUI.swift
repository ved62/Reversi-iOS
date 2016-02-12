//
//  GameLogicUI.swift
//  Reversi iOS
//
//  Created by Владислав Эдуардович Дембский on 12.02.16.
//  Copyright © 2016 Vladislav Dembskiy. All rights reserved.
//

import UIKit
import SpriteKit

class GameLogicUI: SKScene {

    private var atlas: SKTextureAtlas!
    private var gearSprite: SKSpriteNode! // used for indication AI activity

    override func didMoveToView(view: SKView) {
        //create texture atlas for sprites
        atlas = createAtlas()
        gearSprite = createAIIndicator()
        displayEmptyBoard()
    }

    private func createAtlas() -> SKTextureAtlas {
        let chipImages = ChipImages()
        let dictionary = [
            Constants.ChipImages.whiteChip: chipImages.whiteChipWithLight,
            Constants.ChipImages.blackChip: chipImages.blackChipWithLight,
            Constants.cellImage: chipImages.cellImage ]
        return SKTextureAtlas(dictionary: dictionary)
    }

    private func createAIIndicator() -> SKSpriteNode {
        let gear = SKSpriteNode(imageNamed: Constants.gearImage)
        let size = self.size.width/10
        gear.size = CGSize(width: size, height: size)
        return gear
    }

    private func displayEmptyBoard() {
        // Board parameters
        print(self.frame)
        let size = self.size.width
        let boxSideLength = (size)/8
        let squareSize = CGSizeMake(boxSideLength, boxSideLength)
        // draw board
        let yOffset: CGFloat = (boxSideLength/2)
        for row in 0..<8 {
            let xOffset: CGFloat = (boxSideLength/2)
            for col in 0..<8 {
                let square = SKSpriteNode(
                    texture: atlas.textureNamed(Constants.cellImage),
                    size: squareSize)
                square.position = CGPointMake(CGFloat(col) * squareSize.width +
                    xOffset, CGFloat(row) * squareSize.height + yOffset)
                // Set sprite's name in row-col format(e.g., "07", "25")
                square.name = "\(row)\(col)"
                print(square.name, square.position)
                self.addChild(square)
            }
        }
        drawCountsLabel()
    }

    private func drawCountsLabel() {
        let topSquare = self.childNodeWithName("74") as! SKSpriteNode
        let fontSize = topSquare.frame.height * 0.8
        let y = topSquare.frame.maxY + (fontSize/2) - 1
        let countsLabel = SKLabelNode(fontNamed: Constants.Fonts.countsFont)
        countsLabel.text = "White: 0  Black: 0"
        countsLabel.fontSize = fontSize
        countsLabel.position = CGPointMake(self.frame.midX, y)
        print(countsLabel.position)
        countsLabel.fontColor = SKColor.yellowColor()
        countsLabel.name = Constants.countsLabelSpriteName
        countsLabel.zPosition = 2
        self.addChild(countsLabel)
    }

}
