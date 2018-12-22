//
//  TouchResponderView.swift
//  Handwriting
//
//  Created by Clay James on 12/22/18.
//  Copyright © 2018 Clay James. All rights reserved.
//

import Cocoa

class TouchResponderView: NSView {
    
    var drawing: Bool = false
    var strokeCollection: StrokeCollection? {
        didSet {
            // If the strokes change, redraw the view's content.
            if oldValue !== strokeCollection {
                print("new stroke")
            }
        }
    }
    
    override var acceptsFirstResponder: Bool { return true }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override func touchesBegan(with event: NSEvent) {
        if (drawing) {
            print("began")
            let touches = event.touches(matching: NSTouch.Phase.began, in: self)
            let newStroke = Stroke()
            strokeCollection?.activeStroke = newStroke
            
            let coalesced = event.coalescedTouches(for: touches.first!)
            addSamples(for: coalesced)
        }
    }
    
    override func touchesMoved(with event: NSEvent) {
        if (drawing) {
            print("moved")
            let touches = event.touches(matching: NSTouch.Phase.moved, in: self)
            let coalesced = event.coalescedTouches(for: touches.first!)
            addSamples(for: coalesced)
        }
    }
    
    override func touchesEnded(with event: NSEvent) {
        if (drawing) {
            print("ended")
            let touches = event.touches(matching: NSTouch.Phase.ended, in: self)
            let coalesced = event.coalescedTouches(for: touches.first!)
            addSamples(for: coalesced)
            strokeCollection?.acceptActiveStroke()
        }
    }
    
    override func touchesCancelled(with event: NSEvent) {
        strokeCollection?.activeStroke = nil
    }
    
    override func keyDown(with event: NSEvent) {
        if (drawing) {
            print("keydown")
            drawing = false
        }
    }
    
    func addSamples(for touches: [NSTouch]) {
        if let stroke = strokeCollection?.activeStroke {
            // Add all of the touches to the active stroke.
            for touch in touches {
                if touch == touches.last {
                    let sample = StrokeSample(point: touch.normalizedPosition)
                    stroke.add(sample: sample)
                } else {
                    // If the touch is not the last one in the array,
                    //  it was a coalesced touch.
                    let sample = StrokeSample(point: touch.normalizedPosition, coalesced: true)
                    stroke.add(sample: sample)
                }
            }
            // Update the view.
            //self.setNeedsDisplay()
        }
    }
    
}
