//
//  TouchResponderView.swift
//  Handwriting
//
//  Created by Clay James on 12/22/18.
//  Copyright © 2018 Clay James. All rights reserved.
//

import Cocoa

class TouchResponderView: NSView {
    
    var drawing = false
    var strokeCollection = StrokeCollection()
    
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
            strokeCollection.activeStroke = newStroke
            addSample(for: touches.first!)
        }
    }
    
    override func touchesMoved(with event: NSEvent) {
        if (drawing) {
            print("moved")
            let touches = event.touches(matching: NSTouch.Phase.moved, in: self)
            addSample(for: touches.first!)
        }
    }
    
    override func touchesEnded(with event: NSEvent) {
        if (drawing) {
            print("ended")
            let touches = event.touches(matching: NSTouch.Phase.ended, in: self)
            addSample(for: touches.first!)
            strokeCollection.acceptActiveStroke()
        }
    }
    
    override func touchesCancelled(with event: NSEvent) {
        strokeCollection.activeStroke = nil
    }
    
    override func keyDown(with event: NSEvent) {
        if (drawing) {
            print(strokeCollection.strokes)
            drawing = false
        }
    }
    
    func addSample(for touch: NSTouch) {
        if let stroke = strokeCollection.activeStroke {
            stroke.add(sample: touch.normalizedPosition)

            // Update the view.
            //self.setNeedsDisplay()
        }
    }
    
}
