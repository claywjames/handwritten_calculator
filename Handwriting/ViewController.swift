//
//  ViewController.swift
//  Handwriting
//
//  Created by Clay James on 12/11/18.
//  Copyright © 2018 Clay James. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.allowedTouchTypes = [NSTouch.TouchTypeMask.indirect, NSTouch.TouchTypeMask.direct]
    }
    
    @IBAction func drawClicked(_ sender: NSButton) {
        let touchResponderView = self.view as! TouchResponderView
        touchResponderView.drawing = true
    }
}

