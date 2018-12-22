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
    var samples = [StrokeSample]()
    func add(sample: StrokeSample) {
        samples.append(sample)
    }
}

struct StrokeSample {
    let location: NSPoint
    let coalescedSample: Bool
    init(point: NSPoint, coalesced : Bool = false) {
        location = point
        coalescedSample = coalesced
    }
}
