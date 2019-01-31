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
    private var monitor: AnyObject?
    private var drawingBox: DrawingBox?
    
    override var acceptsFirstResponder: Bool { return true }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        drawingBox = (self.subviews.first { (view: NSView) -> Bool in
            view.identifier == NSUserInterfaceItemIdentifier("drawingBox")
            } as! DrawingBox);
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        drawingBox = (self.subviews.first { (view: NSView) -> Bool in
            view.identifier == NSUserInterfaceItemIdentifier("drawingBox")
            } as! DrawingBox);
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override func touchesBegan(with event: NSEvent) {
        if (drawing) {
            let touches = event.touches(matching: NSTouch.Phase.began, in: self)
            drawingBox!.newStroke(touches.first!)
        }
    }
    
    override func touchesMoved(with event: NSEvent) {
        if (drawing) {
            let touches = event.touches(matching: NSTouch.Phase.moved, in: self)
            drawingBox!.continueStroke(touches.first!)
        }
    }
    
    override func touchesEnded(with event: NSEvent) {
        if (drawing) {
            let touches = event.touches(matching: NSTouch.Phase.ended, in: self)
            drawingBox!.endStroke(touches.first!)
        }
    }
    
    override func touchesCancelled(with event: NSEvent) {
        drawingBox!.cancelStroke()
    }
    
    override func keyDown(with event: NSEvent) {
        if (drawing) {
            drawing = false
            showMouse()
        }
    }
    
    func hideMouse() {
        NSCursor.hide()
        CGAssociateMouseAndMouseCursorPosition(0)
    }
    
    func showMouse() {
        NSCursor.unhide()
        CGAssociateMouseAndMouseCursorPosition(1)
    }
    
}
