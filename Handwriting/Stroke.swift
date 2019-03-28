//
//  Swipe.swift
//  Handwriting
//
//  Created by Clay James on 12/20/18.
//  Copyright © 2018 Clay James. All rights reserved.
//

import Cocoa

class StrokeCollection {
    var acceptedStrokes = [Stroke]()
    var activeStroke: Stroke? = nil
    var strokes: [Stroke] {
        if let stroke = activeStroke {
            return acceptedStrokes + [stroke]
        }
        return acceptedStrokes
    }
    
    func acceptActiveStroke() {
        if let stroke = activeStroke {
            acceptedStrokes.append(stroke)
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
