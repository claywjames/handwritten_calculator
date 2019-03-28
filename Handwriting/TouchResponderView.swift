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
            if let images = drawingBox?.strokeImages {
                let tiffs = images.map { (image: NSBitmapImageRep) -> Data in
                    return image.tiffRepresentation!;
                }
                var i = 1;
                let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                for tiff in tiffs {
                    do {
                        let fileUrl = documentsUrl.appendingPathComponent(String(i) + ".tiff").path
                        let url = URL(fileURLWithPath: fileUrl)
                        try tiff.write(to: url, options: Data.WritingOptions.atomic)
                    } catch {
                        NSLog("error in writing -> \(error.localizedDescription)")
                    }
                    i += 1
                }
            }
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
