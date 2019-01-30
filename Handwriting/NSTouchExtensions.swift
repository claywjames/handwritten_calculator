//
//  NSTouchExtensions.swift
//  Handwriting
//
//  Created by Clay James on 12/30/18.
//  Copyright © 2018 Clay James. All rights reserved.
//

import Cocoa

extension NSTouch {

    func pos(_ view:NSView) -> NSPoint{
        let w = view.frame.size.width
        let h = view.frame.size.height
        let touchPos:NSPoint = NSPoint(x:self.normalizedPosition.x, y: self.normalizedPosition.y)
        let touchArea:CGSize = CGSize(width: w, height: h)
        return NSPoint(x: touchPos.x * touchArea.width, y: touchPos.y * touchArea.height)
    }
}
