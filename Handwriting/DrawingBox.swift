//
//  DrawingBox.swift
//  Handwriting
//
//  Created by Clay James on 12/31/18.
//  Copyright © 2018 Clay James. All rights reserved.
//

import Cocoa

class DrawingBox: NSBox {
    
    var strokeCollection = StrokeCollection() {
        didSet {
            self.display()
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    func newStroke(_ touch: NSTouch) {
        let newStroke = Stroke()
        strokeCollection.activeStroke = newStroke
        addSample(for: touch)
        self.display()
    }
    
    func continueStroke(_ touch: NSTouch) {
        addSample(for: touch)
        self.display()
    }
    
    func endStroke(_ touch: NSTouch) {
        addSample(for: touch)
        strokeCollection.acceptActiveStroke()
        self.display()
    }
    
    func cancelStroke() {
        strokeCollection.activeStroke = nil
        self.display()
    }
    
    func addSample(for touch: NSTouch) {
        if let stroke = strokeCollection.activeStroke {
            stroke.add(sample: touch.pos(self))
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let color = NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        color.set()
        
        for line in strokeCollection.strokes {
            let path = NSBezierPath()
            path.lineWidth = 2
            path.move(to: line.samples.first!)
            for point in line.samples {
                path.line(to: point)
            }
            path.stroke()
        }
    }
    
}
