//
//  DrawingBox.swift
//  Handwriting
//
//  Created by Clay James on 12/31/18.
//  Copyright © 2018 Clay James. All rights reserved.
//

import Cocoa

class DrawingBox: NSBox {
    
    var strokes: [Stroke]? {
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
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if let lines = strokes {
            let color = NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            color.set()
            
            for line in lines {
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
    
}
