//
//  Swipe.swift
//  Handwriting
//
//  Created by Clay James on 12/20/18.
//  Copyright © 2018 Clay James. All rights reserved.
//

import Cocoa

class StrokeCollection {
    var strokes = [Stroke]()
    var activeStroke: Stroke? = nil
    
    func acceptActiveStroke() {
        if let stroke = activeStroke {
            strokes.append(stroke)
            activeStroke = nil
        }
    }
}

class Stroke {
    var samples = [NSPoint]()
    func add(sample: NSPoint) {
        samples.append(sample)
    }
}
