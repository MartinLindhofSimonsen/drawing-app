//
//  Squiggle.swift
//  iDoodle
//
//  Created by Martin Lindhof Simonsen on 05/04/2017.
//  Copyright © 2017 Martin Lindhof Simonsen. All rights reserved.
//

import UIKit

class Squiggle: UIBezierPath {

    fileprivate var color: UIColor
    
    init(color: UIColor, strokeWidth: CGFloat) {
        self.color = color
        super.init()
        super.lineWidth = strokeWidth
        super.lineCapStyle = CGLineCap.round
        super.lineJoinStyle = CGLineJoin.round
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // set the Squiggles color before drawing it!
    override func stroke() {
        color.setStroke()
        super.stroke()
    }
    
    
}
