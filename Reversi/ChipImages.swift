//
//  ChipImages.swift
//
//  Reversi iOS
//  
//  This class is using for creating different images for the game usage
//
//  Created by Владислав Эдуардович Дембский on 28.01.16.
//  Copyright © 2016 Vladislav Dembskiy. All rights reserved.
//

import UIKit

final class ChipImages {

    // cell image - background and yelow border
    var cellImage: UIImage!

    // chip images with light effect
    var whiteChipWithLight: UIImage!
    var whiteCIChipWithLight: CIImage!
    var blackChipWithLight: UIImage!
    var blackCIChipWithLight: CIImage!

    private static let size = CGSize(width: 100, height: 100)
    private let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)

    private func chipWithLight(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(ChipImages.size,true,0)
        let context = UIGraphicsGetCurrentContext()
        var fillColor: UIColor
        if let paternImage = UIImage(named:
            Constants.cellBackgroundImage)
        {
            fillColor = UIColor(patternImage: paternImage)
        } else {
            fillColor = UIColor.greenColor()
        }
        CGContextSetFillColorWithColor(context, fillColor.CGColor)
        CGContextAddRect(context, rect)
        CGContextDrawPath(context, CGPathDrawingMode.Fill)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var components: [CGFloat]
        let startColor: UIColor = (color == UIColor.whiteColor()) ?
            UIColor.lightGrayColor() : UIColor.blackColor()
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        if startColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) != true {
            fatalError("can not convert color")
        }
        components = [red,green,blue,alpha] // start color
        let endColor: UIColor = (color == UIColor.whiteColor()) ?
            UIColor.whiteColor() : UIColor.lightGrayColor()
        if endColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) != true {
            fatalError("can not convert color")
        }
        components += [red,green,blue,alpha] // add end color
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let lightPoint = CGPoint(x: center.x+(rect.width/10),
            y: center.y-(rect.height/10))
        let locations: [CGFloat] = [0.0,1.0]
        let gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2)
        CGContextDrawRadialGradient(context, gradient, center, rect.width/2, lightPoint, 0, .DrawsAfterEndLocation)
        CGContextSetStrokeColorWithColor(context, startColor.CGColor)
        CGContextAddEllipseInRect(context, rect)
        CGContextDrawPath(context, CGPathDrawingMode.Stroke)
        let chip = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return chip
    }

    private func createCellImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(ChipImages.size,true,0)
        let context = UIGraphicsGetCurrentContext()
        let borderColor = UIColor.yellowColor()
        var fillColor: UIColor
        if let paternImage = UIImage(named:
            Constants.cellBackgroundImage)
        {
            fillColor = UIColor(patternImage: paternImage)
        } else {
            fillColor = UIColor.greenColor()
        }
        CGContextSetFillColorWithColor(context, fillColor.CGColor)
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor)
        CGContextAddRect(context, rect)
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        let cellImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return cellImage
    }

    init() {
        cellImage = createCellImage()

        whiteChipWithLight = chipWithLight(UIColor.whiteColor())
        whiteCIChipWithLight = whiteChipWithLight.CIImage

        blackChipWithLight = chipWithLight(UIColor.blackColor())
        blackCIChipWithLight = blackChipWithLight.CIImage
    }
}

