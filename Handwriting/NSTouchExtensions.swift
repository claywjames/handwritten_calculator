//
//  NSTouchExtensions.swift
//  Handwriting
//
//  Created by Clay James on 12/30/18.
//  Copyright © 2018 Clay James. All rights reserved.
//

import Cocoa

func +(lhs: NSPoint, rhs: NSPoint) -> NSPoint {
    return NSPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

extension NSTouch {
    /**
     * Returns the relative position of the touch to the view
     * NOTE: the normalizedTouch is the relative location on the trackpad. values range from 0-1. And are y-flipped
     */
    func pos(_ view:NSView) -> NSPoint{
        let w = view.frame.size.width
        let h = view.frame.size.height
        let touchPos:NSPoint = NSPoint(x:self.normalizedPosition.x, y: self.normalizedPosition.y)
        let deviceSize:CGSize = self.deviceSize
        let deviceRatio:CGFloat = deviceSize.width/deviceSize.height/*find the ratio of the device*/
        let viewRatio:CGFloat = w/h
        var touchArea:CGSize = CGSize(width: w, height: h)
        /*Unifor-shrink the device to the view frame*/
        if deviceRatio > viewRatio {/*device is wider than view*/
            touchArea.height = h/viewRatio
            touchArea.width = w
        }else if deviceRatio < viewRatio {/*view is wider than device*/
            touchArea.height = h
            touchArea.width = w/deviceRatio
        }/*else ratios are the same*/
        let touchAreaPos:NSPoint = NSPoint(x:(w - touchArea.width)/2, y:(h - touchArea.height)/2)
        return NSPoint(x: touchPos.x * touchArea.width, y: touchPos.y * touchArea.height) + touchAreaPos
    }
}
