//
//  DoodleView.swift
//  iDoodle
//
//  Created by Martin Lindhof Simonsen on 05/04/2017.
//  Copyright © 2017 Martin Lindhof Simonsen. All rights reserved.
//

import UIKit

class DoodleView: UIView {

    var strokeWidth: CGFloat = 10.0
    var drawingColor: UIColor = UIColor.black
    
    fileprivate var finishedSquiggles = [Squiggle]()
    fileprivate var currentSquiggle = [UITouch: Squiggle]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isMultipleTouchEnabled = true
    }
    
    // draw the complete squiggle and the current one
    override func draw(_ rect: CGRect) {
        for squiggle in finishedSquiggles {
            squiggle.stroke()
        }
        for squiggle in currentSquiggle.values {
            squiggle.stroke()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let squiggle = Squiggle(color: drawingColor, strokeWidth: strokeWidth)
            squiggle.move(to: touch.location(in: self))
            currentSquiggle[touch] = squiggle
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            currentSquiggle[touch]?.addLine(to: touch.location(in: self))
            setNeedsDisplay()
        }
    }
    
    // Lifted finger => currentSquillge moved to finishedSquiggles
    // currentSquiggle removed
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let squiggle = currentSquiggle[touch] {
                finishedSquiggles.append(squiggle)
                currentSquiggle[touch] = nil
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentSquiggle.removeAll()
    }
    
    // Called from ViewController to undo last squiggle.
    func undo() {
        finishedSquiggles.removeLast()
        setNeedsDisplay()
    }
    
    func clear() {
        finishedSquiggles.removeAll()
        setNeedsDisplay()
    }
    
    // computed property that represent the doodle
    var image: UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0.0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
}
